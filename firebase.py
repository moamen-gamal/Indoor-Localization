# Imports
#-------------------------------------------------------------------------------
import pyrebase
# Config/Setup
# -------------------------------------------------------------------------------
firebaseConfig = {
    "apiKey": "AIzaSyBPWK0Gp9TdqpUyPIeoHfsfs-ErEvQYbKk",
    "authDomain": "espdemo42.firebaseapp.com",
    "projectId": "espdemo42",
    "databaseURL": "https://espdemo42-default-rtdb.firebaseio.com/",
    "storageBucket": "espdemo42.appspot.com",
    "messagingSenderId":  "719152769554",
    "appId":"1:719152769554:web:fd8065f9f4f9d19ea046cb",
    "measurementId": "G-7D6JSH27P5"
}
firebase = pyrebase.initialize_app(firebaseConfig)
db = firebase.database()

def send2firebase(dataID,label):
    
    # data = {"Age": 21, "Name": "samy", "Employed": True}
    # #-------------------------------------------------------------------------------
    # # Create Data
    # # db.push(data)
    # db.child("Users").child("third").set(data)
    # # # Read Data

    # jenna = db.child("Users").child("third").get()
    # jenna = db.child("Users").child("third").child("Age").get()
    # print(jenna.val())
    #-------------------------------------------------------------------------------
    # Update Data
    # db.child("Users").child("third").update({"Name": "Larry"})
    # Remove Data
    #Delete 1 Value
    # db.child("Users").child("FirstPerson").child("Age").remove()
    # Delete whole Node
    # db.child("Users").remove()

    # ///////////////////////////////////////////////////////////////////
    # for loop
    # np array to ml model 
    # int the result
    # send int to firebase and time 
    # retrieve int from firebase to flutter 
    # flutter chick every 0.1 sec
    # ////////////////////////////////////////////////////////////////////
    db.child('rooms').child(str(dataID)).set(str(label))

def getLastFromDataBase():
    Je = db.child("rooms").get()
    str = "".join(Je.val()[-20:])
    return str