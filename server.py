import string
import collections
try:
    from collections import abc
    collections.MutableMapping = abc.MutableMapping
except:
    pass
from tokenize import String
from flask import Flask
from flask import request
from firebase import *
import pickle

saved_networks = ["MO",
                "medhat",
                "El-lab",
                "RehabLab",
                "Elmodarag",
                "STUDBME1",
                "STUDBME2",
                "WE_99ECD6",
                "noran",
                "mawlana",
                "Redmi7788"]
RSSI=[[0, 0, 0, 0, 0, 0, 0, 0, 0 , 0 , 0]]
app = Flask(__name__)
count =0
last_label =-1
@app.route('/helloesp', methods = ['POST','GET'])
def helloesp():
    for i in range(0,8):
        value = request.args.get(str(i))
        RSSI[0][i] = int(value)
    global count
    count +=1
    loaded_model = pickle.load(open('KNN.sav', 'rb'))
    
    label =loaded_model.predict(RSSI)
    global last_label
    last_label = str(label[0])
    print(RSSI)
    print(label[0])
    send2firebase(str(count),label[0]) 
    return 'recieved readings'

@app.route('/send2flutter',methods=['GET','POST'])
def send2flutter():    
    return str(last_label)
    request.close()
    

@app.route('/sendLastReadings',methods =['GET','POST'])
def sendLast2Flutter():
    return(getLastFromDataBase())

if __name__ == '__main__':
    app.run('0.0.0.0',port=5000,threaded=True)