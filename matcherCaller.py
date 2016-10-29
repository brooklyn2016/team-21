import subprocess
from pydub import AudioSegment


def convAudio(fileName):
    sound = AudioSegment.from_mp3(fileName+".mp3")
    sound.export(fileName+".wav", format="wav")

def getSimilarity():
    p1 = subprocess.Popen(["/usr/bin/java", "matcher"], stdout=subprocess.PIPE)
    print(p1.stdout.read())

def getWord(audioFileName, fingerprints):

    return ""

def getFingerPrint(audioFileName):
    return ""


convAudio("appa")
