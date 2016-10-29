from flask import Flask, request, jsonify, abort
import os
import json
import hashlib
from matcherCaller import getWord, getFingerPrint
from sqlalchemy_autistic import AddRecording, GetRecordings

app = Flask(__name__)

#I propose this terrible list
#it will be our temp 
theList = []
roster = [
        {'name': "Kate", 'img': "http://www.cdc.gov/ncbddd/autism/images/autism-facts-graphic2.jpg"},
        {'name': "Molly", 'img': "https://sumonyusuf.files.wordpress.com/2014/09/03_mg_0309.jpg"},
        {'name': "Carlos", 'img': "http://i.usatoday.net/news/_photos/2012/05/14/1-in-3-autistic-young-adults-lack-jobs-education-DU1FRCH6-x-large.jpg"},
        {'name': "Pete", 'img': "http://media3.s-nbcnews.com/i/newscms/2016_29/1143945/ralph-autism-pokemon-drawing3-today-tease-160718_d99bb087a083df8258a0a36d16246bfc.jpg"},
        #{'name': "Joshua", 'img': "http://cdn.images.express.co.uk/img/dynamic/1/590x/autistic-378222.jpg"},
        {'name': "Ida", 'img': "http://www.missidahousa.com/contestants/hires/Ariana%20Whitfield%20-%20Miss%20Coeur%20dAlene%20Teen%20USA%202013lo.jpg"},
        #{'name': "Scott", 'img': "https://www.libertymutual.com/insurance-content/title-hero/auto/car-insurance-for-teens/auto-insurance-for-teenagers.jpg?v=2015101808324220"},
        {'name': "Panda", 'img': "http://www.hiphopfind.com/upload/ciggjljpms.jpg"},
        ]

def send_json(l):
    return jsonify(**{'data':l}) #this was ugly. Needed to move it 


@app.route('/')
def hello_world():
    return ':p'

@app.route('/getRoster', methods=['GET'])
def getRoster():
    return send_json(roster)#json.dumps(roster)


#This is where the work is at
@app.route('/meaning', methods=['GET', 'POST'])
def meaning():
    if request.method == 'POST':
        #grab name, audio, meaning
        name=request.form['name']
        audio_id=request.form['audio_id']
        meaning=request.form['meaning']
        audio=[entry for entry in theList if entry['hash'] == audio_id][0]

        AddRecording(name, getFingerPrint(audio), meaning)
        #theList.append("banana fest")
        return send_json("success!")
    else:
        #grab name, audio
        
        name = request.args.get('name')
        print(':p')
        audio = request.files['audio']
        
        audio_name = audio.filename
        
        meaning=""
        recordings = GetRecordings(name)

        audio.save(audio_name)

        word = getWord(audio_name, recordings)
        
        if word != 'None':
            meaning=word
        else:
            hashmd5=hashlib.md5(audio).hexdigest()
            theList.append({'hash':hashmd5,'audio':audio_name})
            #return this is BS
            #abort('400', send_json(hashmd5))
        return send_json(meaning)

if __name__ == "__main__":
    if os.environ.get('FORCE_B_W_U') == 'None':
        app.run(debug=True)
    else:
        app.run(host='0.0.0.0')
