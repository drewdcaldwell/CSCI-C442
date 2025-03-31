################################################################################################################
#                                          xml_to_json.py                                           03/31/2025 #             
################################################################################################################
################################################################################################################
#  CSCI-C442 Assignment 3                 Drew D. Caldwell                           Indiana University-Kokomo #             
################################################################################################################
#                                                                                                              # 
#  This program serves as a converter that will accept the 'twitter.xml' file and convert it into a json file. # 
#  After running the user will have the ability to specify the location that they would like to store the new  #
#  JSON file, as well as create their own name that they can name to their own preference.                     # 
#                                                                                                              #
################################################################################################################




import tkinter as tk
from tkinter import messagebox
import json
import xmltodict   
    
    
def xml_to_json():
        
    try:
        xml_file = getFilePath()
        json_file = getDestinationPath()

        try:
            with open(xml_file, 'r', encoding='utf-8') as xml_f:
                xml_content = xml_f.read()
                json_data = xmltodict.parse(xml_content)  

            with open(json_file, 'w', encoding='utf-8') as json_f:
                json.dump(json_data, json_f, indent=4)  

            messagebox.showinfo("Message", "%s has been created." % json_file)
        except:
            messagebox.showinfo("Message", "Please enter a valid XML file, Path, and Json file name")
    except:
        messagebox.showinfo("Message", "Please enter a valid XML file, Path, and Json file name")

                
def getFilePath():
    filePath_input = entry1.get()
    return filePath_input

def getDestinationPath():
    destinationPath_input = entry2.get() + entry3.get()
    return destinationPath_input
    
       

# Create the main window
root = tk.Tk()
root.title("Twitter XML to JSON converter")
root.geometry("800x400")

# Create a label
label = tk.Label(root, text="Enter the XML file path, destination path, and JSON file name", font=("Arial", 15))
label.pack(pady=10)
label2 = tk.Label(root, text = r"Example: H:\VSCODE\Assignment3\xml_input\twitter.xml", font = ("Arial", 12))
label2.pack(pady=10)
entry1 = tk.Entry(root, width=80)
entry1.pack(pady=20)
label4 = tk.Label(root, text = r"Example: H:\VSCODE\Assignment3\json_output", font = ("Arial", 12))
label4.pack(pady=10)
entry2 = tk.Entry(root, width=80)
entry2.pack(pady=20)
label3 = tk.Label(root, text = r"Example: \twitter_XML_to_JSON.json", font = ("Arial", 12))
label3.pack(pady=10)
entry3 = tk.Entry(root, width=80)
entry3.pack(pady=20)

# Create a button
button2 = tk.Button(root, text="XML -> JSON", command=xml_to_json)
button2.pack()


# Run the application
root.mainloop()