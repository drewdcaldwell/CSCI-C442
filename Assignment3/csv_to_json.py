################################################################################################################
#                                          csv_to_json.py                                           03/31/2025 #             
################################################################################################################
################################################################################################################
#  CSCI-C442 Assignment 3                 Drew D. Caldwell                           Indiana University-Kokomo #             
################################################################################################################            
#                                                                                                              # 
#  This program serves as a converter that will accept the 'twitter.csv' file and convert into a json file.    # 
#  After running the user will have the ability to specify the location that they would like to store the new  #
#  JSON file, as well as create their own name that they can name to their own preference.                     # 
#                                                                                                              # 
#  Due to the CSV file not already having titles for the columns we had to explicitly define them here. In the #
#  Future we will take those and generalize this so that we can quickly convert CSV files to JSON files.       # 
#                                                                                                              # 
################################################################################################################

import tkinter as tk
from tkinter import messagebox
import csv
import json
import xmltodict   
    
def csv_to_json():
        
    try:
        # Get the path of the CSV file we want to convert to JSON
        csvFile = getFilePath() # EX. csvFile = r"C:\Users\drewc\CSCI-C442\CSCI-C442\A3 Final GUI\twitter.csv"

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
        try:
            with open(output_filename, 'w', encoding='utf-8') as json_file:
                json.dump(jsonFile, json_file, ensure_ascii=False, indent=4)

                # Notify user it has been converted
                messagebox.showinfo("Message", "%s has been created." % (output_filename))
        except:
            messagebox.showinfo("Message", "Please use the .json extension")
    except:
        messagebox.showinfo("Message", "Please enter a valid CSV file" )

    
                
def getFilePath():
    filePath_input = entry1.get()
    return filePath_input

def getDestinationPath():
    destinationPath_input = entry2.get() + entry3.get()
    return destinationPath_input
    
       

# Create the main window
root = tk.Tk()
root.title("Twitter CSV to JSON converter")
root.geometry("800x500")

# Create a label
Flabel = tk.Label(root, text="Welcome to the Twitter CSV to JSON converter", font=("Arial", 15))
Flabel.pack(pady=10)
label = tk.Label(root, text="Enter the CSV file path, destination path, and JSON file name", font=("Arial", 15))
label.pack(pady=10)
label2 = tk.Label(root, text = r"Example: H:\VSCODE\Assignment3\csv_input\twitter.csv", font = ("Arial", 12))
label2.pack(pady=10)
entry1 = tk.Entry(root, width=80)
entry1.pack(pady=20)
label4 = tk.Label(root, text = r"Example: H:\VSCODE\Assignment3\json_output", font = ("Arial", 12))
label4.pack(pady=10)
entry2 = tk.Entry(root, width=80)
entry2.pack(pady=20)
label3 = tk.Label(root, text = r"Example: \twitter_CSV_to_JSON.json", font = ("Arial", 12))
label3.pack(pady=10)
entry3 = tk.Entry(root, width=80)
entry3.pack(pady=20)


# Create a button
button1 = tk.Button(root, text="CSV -> JSON", command=csv_to_json)
button1.pack()


# Run the application
root.mainloop()