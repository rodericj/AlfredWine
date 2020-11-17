#!/bin/bash
echo $@

# Fetch from cellar tracker

curl -s "https://www.cellartracker.com/xlquery.asp?User=$CELLAR_TRACKER_UNAME&Password=$CELLAR_TRACKER_PASSWORD&Format=html&Table=Consumed&Location=1" > cool.html
curl -s "https://www.cellartracker.com/xlquery.asp?User=$CELLAR_TRACKER_UNAME&Password=$CELLAR_TRACKER_PASSWORD&Format=csv&Table=Consumed&Location=1" | 

# Fix the encoding of the strings

iconv -f ISO-8859-1 -t UTF-8 | 

# convert to json

csvtojson |

# massage the data so that we have a uid, arg, title, subtitle, icon. Remove things we don't care about
jq -a '[.[] | 
      .["uid"] = .iWine |
      .["title"] = .Vintage + " " + .Wine |
      .["arg"] = "\(.iWine),\(.title),\(.PurchaseNote),\(.ConsumptionNote)" |
      .["subtitle"] = "\(.MasterVarietal) - \(.Locale) -  $\(.Price) " |
      .["icon"] = {"path": "~/dev/alfredWine/\(.Type).jpeg"} |
      .["quicklookurl"] = "https://www.cellartracker.com/wine.asp?iWine=\(.iWine)&searchId=E566BF43%23selected%253DW3483315_B0136311576_K60f9e67a1813808d847de46d86ffa7ae" |
      del(.FP, .CHG, .DR, .JM, .PG, .MY, .CT, .WAL, .TWF, .TT, .IWR, .MFW, .JG, .GV, .JK, .LD, .CW, .WFW, .PR, .SF, .WD, .RR, .JH, .WWR, .WS, .IWC, .WA, .BH, .AG, .WE, .JR, .RH, .SJ)]' | 

jq -a '{"items" : .}' 
