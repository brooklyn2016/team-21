from flask import Flask, request, jsonify
import os
import json

app = Flask(__name__)

#I propose this terrible list
#it will be our "database"
theList = []
roster = [
        {'name': "Kate", 'img': "http://www.cdc.gov/ncbddd/autism/images/autism-facts-graphic2.jpg"},
        {'name': "Molly", 'img': "https://sumonyusuf.files.wordpress.com/2014/09/03_mg_0309.jpg"},
        {'name': "Carlos", 'img': "http://i.usatoday.net/news/_photos/2012/05/14/1-in-3-autistic-young-adults-lack-jobs-education-DU1FRCH6-x-large.jpg"},
        {'name': "Pete", 'img': "http://media3.s-nbcnews.com/i/newscms/2016_29/1143945/ralph-autism-pokemon-drawing3-today-tease-160718_d99bb087a083df8258a0a36d16246bfc.jpg"},
        {'name': "Joshua", 'img': "http://cdn.images.express.co.uk/img/dynamic/1/590x/autistic-378222.jpg"},
        {'name': "Ida", 'img': "http://www.missidahousa.com/contestants/hires/Ariana%20Whitfield%20-%20Miss%20Coeur%20dAlene%20Teen%20USA%202013lo.jpg"},
        {'name': "Scott", 'img': "https://www.libertymutual.com/insurance-content/title-hero/auto/car-insurance-for-teens/auto-insurance-for-teenagers.jpg?v=2015101808324220"},
        {'name': "Panda", 'img': "http://www.hiphopfind.com/upload/ciggjljpms.jpg"},
        ]

@app.route('/')
def hello_world():
    return ':p'

@app.route('/getRoster', methods=['GET'])
def getRoster():
    return jsonify(**{'data': roster})#json.dumps(roster)

@app.route('/meaning', methods=['GET', 'POST'])
def meaning():
    if request.method == 'POST':
        theList.append("banana fest")
        return "This means: Apple"
    else:
        return "Meaning uploaded!! :D"

if __name__ == "__main__":
    if os.environ.get('FORCE_B_W_U') == 'None':
        app.run(debug=True)
    else:
        app.run(host='0.0.0.0')
