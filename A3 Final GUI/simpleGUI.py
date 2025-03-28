import tkinter as tk
from tkinter import messagebox
import csv
import json
import xmltodict   
    
def csv_to_json():
    
    csvFile = getFilePath()    
    # csvFile = r"C:\Users\drewc\CSCI-C442\CSCI-C442\A3 Final GUI\twitter.csv"
    
    tweets = []
    
    with open(csvFile, mode = 'r', encoding = 'utf-8') as file:
        cursor = csv.reader(file)
    
        next(cursor)
    
        for row in cursor:
            tweet = {
                    "Text": row[0],  
                    "ID": int(row[1]),  
                    "QuotedID": int(row[2]) if row[2] else 0,  
                    "RetweetedText": row[3] if row[3] else "",  
                    "RetweetedHandle": row[4] if row[4] else "",
                    "RetweetedName": row[5] if row[5] else "",  
                    "Retweets": int(row[6]), 
                    "Source": row[7],  
                    "UserHandle": row[8], 
                    "UserName": row[9]  
                }

            tweets.append(tweet)

    jsonFile = {"Tweets":tweets}
    
    output_filename = getDestinationPath()
    with open(output_filename, 'w', encoding='utf-8') as json_file:
        json.dump(jsonFile, json_file, ensure_ascii=False, indent=4)
        
        messagebox.showinfo("Message", "%s now converted to 'twitter_csv_to_json.json' in project folder" % (csvFile))
    
    
def xml_to_json():
    
    xml_file = getFilePath()
    json_file = getDestinationPath()
    
    try:
        with open(xml_file, 'r', encoding='utf-8') as xml_f:
            xml_content = xml_f.read()
            json_data = xmltodict.parse(xml_content)  
            
        with open(json_file, 'w', encoding='utf-8') as json_f:
            json.dump(json_data, json_f, indent=4)  
    
        messagebox.showinfo("Message", "%s now converted to twitter_xml.json in project folder" % xml_file)
        
    except Exception as e:
        print(f"Error: {e}")
        
        
def getFilePath():
    filePath_input = entry1.get()
    return filePath_input

def getDestinationPath():
    destinationPath_input = entry2.get()
    return destinationPath_input
    
       

# Create the main window
root = tk.Tk()
root.title("DataFile Conversion GUI")
root.geometry("800x400")

# Create a label
label = tk.Label(root, text="Enter the file path, destination path, and what operation you would like.", font=("Arial", 15))
label.pack(pady=10)
label2 = tk.Label(root, text = r"Example: C:\Users\drewc\CSCI-C442\CSCI-C442\A3 Final GUI\twitter.csv ", font = ("Arial", 12))
label2.pack(pady=10)
entry1 = tk.Entry(root, width=80)
entry1.pack(pady=20)
label3 = tk.Label(root, text = r"Example: C:\Users\drewc\CSCI-C442\CSCI-C442\A3 Final GUI\twitterCSV_to_JSON ", font = ("Arial", 12))
label3.pack(pady=10)
entry2 = tk.Entry(root, width=80)
entry2.pack(pady=20)

# Create a button
button1 = tk.Button(root, text="CSV -> JSON", command=csv_to_json)
button2 = tk.Button(root, text="XML -> JSON", command=xml_to_json)
button1.pack()
button2.pack()


# Run the application
root.mainloop()
