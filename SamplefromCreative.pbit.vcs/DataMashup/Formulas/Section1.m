section Section1;

shared Association = let
    Source = Excel.Workbook(File.Contents("C:\Users\AmaniBenHadjHassen\Documents\Sales & Marketing Datas.xlsx"), null, true),
    Association_Sheet = Source{[Item="Association",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Association_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"RuleID", Int64.Type}, {"LeftItemSetId", Int64.Type}, {"RightItemSetId", Int64.Type}, {"Probability", type number}, {"Importance", type number}, {"Support", Int64.Type}}),
    #"Inserted Merged Column" = Table.AddColumn(#"Changed Type", "Merged", each Text.Combine({Text.From([LeftItemSetId], "en-CA"), Text.From([RightItemSetId], "en-CA")}, ""), type text),
    #"Removed Duplicates" = Table.Distinct(#"Inserted Merged Column", {"Merged"}),
    #"Removed Columns" = Table.RemoveColumns(#"Removed Duplicates",{"Merged"})
in
    #"Removed Columns";

shared Sales = let
    Source = Excel.Workbook(File.Contents("C:\Users\AmaniBenHadjHassen\Documents\Sales & Marketing Datas.xlsx"), null, true),
    Sales_Sheet = Source{[Item="Sales",Kind="Sheet"]}[Data],
    #"Promoted Headers1" = Table.PromoteHeaders(Sales_Sheet, [PromoteAllScalars=true]),
    #"Changed Type1" = Table.TransformColumnTypes(#"Promoted Headers1",{{"ProductID", Int64.Type}, {"StoreID", Int64.Type}, {"Status", type text}, {"ID", Int64.Type}, {"Unit", Int64.Type}, {"Amount", Currency.Type}, {"Date", type date}})
in
    #"Changed Type1";

shared Store = let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("bZLNasNADITfxec0SPsjrY5paaFQSkohl5DDus3B4NjUsUsfv6tk7VKyJ8sLn0Yz0n5fYbWqNnUdz+n7+DMehy62qbwLvGZ21tv043At5MlKqqvDal8Zhdrma2oKFIrx2tWZNaBxxs2UtrqPQx1vIRJvxWQpH4TCDCn9HtvvqTSgMyySKUT6k/KpeIonVXru/jECQYAzA44uo14YSsXLsS/JMFp3RYJFNn5GtM8udpvh/HlsS6D3EK4gpwBhAfXxNY7TUMrCWnA5dnZgYHGlVrexLdmiQCZkW2yQabGFoFQzTKdbqQBANsfOQF4WKVR+259KlJcgIVMklI5kofT1bWrq0rYCIVieY0z7Ws4J1e1D3439uS9Ys4HAzJxmunA67q75GPuhKWXCHn3eG4ulfFSHXw==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [ManufacturerID = _t, Manufacturer = _t, Type = _t, Longitude = _t, Latitude = _t, image = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"ManufacturerID", Int64.Type}, {"Manufacturer", type text}, {"Type", type text}, {"Longitude", type number}, {"Latitude", type number}, {"image", type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"ManufacturerID", "StoreID"}, {"Manufacturer", "Store"}})
in
    #"Renamed Columns";

shared Calendar = let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("fZSxisMwDIZfJWQuqSQ7dtztlg6FPkHpkIMbrxyFG+7tq4vcwD9I4IQUvg/kfk5ut5H4qEuI28ByItI1rNPwPY2HkfW6rI/+xOP9oHzxeQFeNp6Tzyfg08YL+XwGPhtffX4Gfrb5dR5x+KLX+euz76TY/OTzFfhqfPX5BfjF5s8+34Bv+/zJ60V6u67P/tfqz/cOXIPR4H0PriFoyL4L10hoWOfEgZHRsNKkU2XP+E/98fPsh4StNefAKGhYbeHAqGhYb1kCY0HDitN81OUYbdv5Xz+8bM1ZfEMIDOnNW2AwGtZcSmAIGtZcj61+DBxje7V/H/2lEmtOLTAyGtacS2DMaFhzSYFR0LDmiQKjoqHN7y8=", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [Date = _t, Week = _t, #"Month Name" = _t, MonthSort = _t, #"Week of Year" = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Date", type datetime}, {"Week", Int64.Type}, {"Month Name", type text}, {"MonthSort", Int64.Type}, {"Week of Year", Int64.Type}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Month Name", "Month"}}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Renamed Columns",{{"Date", type date}}),
    #"Removed Columns" = Table.RemoveColumns(#"Changed Type1",{"Week of Year"})
in
    #"Removed Columns";

shared #"Analysis DAX" = let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i44FAA==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [Column1 = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Column1", type text}}),
    #"Removed Columns" = Table.RemoveColumns(#"Changed Type",{"Column1"})
in
    #"Removed Columns";

shared #"Design DAX" = let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i44FAA==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [Column1 = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Column1", type text}}),
    #"Removed Columns" = Table.RemoveColumns(#"Changed Type",{"Column1"})
in
    #"Removed Columns";

shared Customer = let
    Source = Excel.Workbook(File.Contents("C:\Users\AmaniBenHadjHassen\Documents\Sales & Marketing Datas.xlsx"), null, true),
    Data_Sheet = Source{[Item="Data",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Data_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"ID", Int64.Type}, {"Unit", Int64.Type}, {"Gender", type text}, {"Age", type text}}),
    #"Replaced Value" = Table.ReplaceValue(#"Changed Type","M","Male",Replacer.ReplaceText,{"Gender"}),
    #"Replaced Value1" = Table.ReplaceValue(#"Replaced Value","F","Female",Replacer.ReplaceText,{"Gender"})
in
    #"Replaced Value1";

shared #"Issues and Promotions" = let
    Source = Excel.Workbook(File.Contents("C:\Users\AmaniBenHadjHassen\Documents\Sales & Marketing Datas.xlsx"), null, true),
    #"Issues and Promotions_Sheet" = Source{[Item="Issues and Promotions",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(#"Issues and Promotions_Sheet", [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"ID", Int64.Type}, {"Issue", type text}, {"Promotion", type text}})
in
    #"Changed Type";

shared STable = let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i45Wci4tKkrNK1HwSy1RCE7MSS1W0lEyVIrViVZyrSgpSlQIKMpPyywBChopxcYCAA==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [Metric = _t, Sort = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Metric", type text}, {"Sort", Int64.Type}})
in
    #"Changed Type";

shared #"Tooltip Info" = let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("pZJBT8IwGIb/SrMz8o2Wjs0bARLloEjkYAiHbpRtGWtnW8Dx651pQnBoCnprmqd93u/Nt1x6T9wgzbZcozuUMMNTqWoUK86KtTwIr+NlxlT6HiAvWZofuep+HbjOWFJ0E1k292mEMQQhjeCt3i/iXTfNN62H5zxUpeVSb9X5HkAbqfjt9j6QHgngMRTJ/Nlpl5a7tBe8RrnYbHdcJFzpa+09oNj3Ybpm40XltG8tZ+1zbnZK/K/6PlAa+MDHU1nE7uEt19a3ikfXywc4CEHF0xf24ZZbri3/Y+8YaN8PIA9mRZa5d85y526kmtIbvzjtwF6jQ8YMuvjr1xAECKGQPZTvi6Mzg7DcTxlu1GKIKA5hXkyS4at7dstZ70weuBpW1dU9E8DRIIJ1PZqQkXtGyzWu1Sc=", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [nombre = _t, URL = _t, DLINK = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"nombre", type text}, {"URL", type text}, {"DLINK", type text}})
in
    #"Changed Type";

shared Details = let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("lVXbcpswEP0VDc/OxMF2mjzKgBtNsWEwzmXSPChY2JrIKCNEU/ep39JP65dUK18mDYEQZjxjpLO7hz1npft7By98Esy8wOk5Z+YXxUGCUxLNcGjeXOehV4Ngs3eXEs8iBhYRhzidRMnUhvScOLoJEjQmyA/m39IoNkvD93Bo/yTsWSqNrjl7QWZ51JpzGo1JCFwuOqScykcu2DHzpQ1ZkNPFreXec0J8Fy1S+LJ+be+Qy5NFyUvNCo1CupWVBvhZDe5FYZTAltuYacozJUuZa5NTSFUCetCIvuKrNRTXipa25rAGHSd45pPZV9gddSgb5TnPOBUoVnJZZdoyOP9MYChX0kZ9qUWRWRokE7wzykVjUlLoimv+gwGsrsix64JRhXyqKfJN9xV/rDSXBehclyq4Nb49mNSta3NsqXw5SSVgmkXyqBBIS4SzQ71miaa84JtqY8jy7Ana4tY1MszAoHhPrlkmz/S6PIkF1blUG8A2K5MwIx9bGkMaX2ZbAO8EsdM5J3M7cz1nEuB0kQRz9L3q991z5OEYm/khKQkA4l68F3Qo4ituWjGVS5DKvfwQqtdKVqs1UO23gVMphebPgDtrw+2fv7//IJ/ltBIwBQO3Y8j+CIjpCugPBm1h17ysjLmvGF0yBehhxyL7T0Ep+2nJjT4Z94bkeVv4zZpqRHLAvav1AYcLKra/bL5WeV/RIUWmGC3Zqc92fyC4VfBXwRNeLA05phjSa17+N67Ivue52SygQcNWY0y40EyZbhRAYNhqjrGUTxuqnmC5qyUMs2dBt2jOBMu0GZ+d7hDQag9zCC85fI7xyMTMJtWaFysAdfWJPcfsoQ+Yzi7hWthOtPribZkxtTfL8GOTaJ5ZZFebwE2oKdyDfKdQZ4tIxbLdLTYyDnj4Bw==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [#"Design Factor" = _t, DFSort = _t, Topic = _t, TSort = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"DFSort", Int64.Type}, {"TSort", Int64.Type}})
in
    #"Changed Type";

shared Product = let
    Source = Excel.Workbook(File.Contents("C:\Users\AmaniBenHadjHassen\Documents\Sales & Marketing Datas.xlsx"), null, true),
    Product_Sheet = Source{[Item="Product",Kind="Sheet"]}[Data],
    #"Promoted Headers" = Table.PromoteHeaders(Product_Sheet, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Product", type text}, {"ProductID", Int64.Type}, {"Category", type text}, {"CategoryID", Int64.Type}, {"Segment", type text}, {"SegmentID", Int64.Type}, {"Product Image", type text}, {"Category Image", type text}, {"Segement Color", type text}, {"Segment image", type text}, {"Price", Int64.Type}, {"Price Range", type text}})
in
    #"Changed Type";