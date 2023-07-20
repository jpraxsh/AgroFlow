from flask import *
 

app = Flask(__name__)
 
temp = '1.5'
hum = '23'
mois='1.2'
motor = 'false'
mois_con = 'wet'
@app.route('/')
def hello_world():
    return 'Hello World'

@app.route('/send',methods=['get','post'])
def send():
    global temp,hum,mois,mois_con
    temp = request.args['temp']
    hum = request.args['hum']
    mois= request.args['mois']
    if int(mois) >= 1600 and int(mois)<2000:
        mois_con = "Normal"
    elif int(mois)<1600:
        mois_con = 'Wet'
    else :
        mois_con = "Dry"

    print(temp,hum,mois)
    return {'motor':motor}

@app.route('/fetch', methods=['post'])
def fetch():
    if(request.method=='POST'):
        global motor
        condition = request.json['motor']
        motor=condition
        print(motor)
        result = {}
        result['temp']=temp
        result['hum']=hum
        result['mois']=mois_con
        result['con']=motor
        return result
@app.route('/getMotor',methods=['POST'])
def getMotor():
    if(request.method=='POST'):
        result = {}
        result['con']=motor
        return result


if __name__ == '__main__':
    app.run(debug=True,port=2003,host='0.0.0.0')