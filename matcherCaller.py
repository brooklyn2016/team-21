import subprocess
import binascii
from pydub import AudioSegment


def convAudio(fileName):
    sound = AudioSegment.from_mp3(fileName+".mp3")
    sound.export(fileName+".wav", format="wav")

def getSimilarity():
    p1 = subprocess.Popen(["/usr/bin/java", "matcher"], stdout=subprocess.PIPE)
    print(p1.stdout.read())

def getWord(audioFileName, recordings):
    convAudio(audioFileName)
    hexStr = ','.join([binascii.hexlify(bytearray(fp[0])) for fp in recordings])

    p1 = subprocess.Popen(["/usr/bin/java", "matcher", "getSimilarity", audioFileName+".wav", hexStr], stdout=subprocess.PIPE)
    output = p1.stdout.read()
    
    return output

def getFingerPrint(audioFileName):
    convAudio(audioFileName)
    p1 = subprocess.Popen(["/usr/bin/java", "matcher", "getFingerPrint", audioFileName+".wav"], stdout=subprocess.PIPE)
    output = p1.stdout.read()


    return bytearray(output)


convAudio("appa")
