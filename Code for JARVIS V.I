
                                     # IMPORTING MODULES 

import pyttsx3                          #text to speech converting module
import speech_recognition as sr         # recognizes speech
import datetime                         # used to get current date and time
import wikipedia                        # used to search wikipedia 
import webbrowser                       # used to run internet
import pywhatkit                        # used to play videos and songs on youtube
import pyjokes                          # tells a joke

engine = pyttsx3.init('sapi5') 
voices = engine.getProperty('voices')   # Getting voices 

engine.setProperty('voice',voices[1].id)  # Selecting voice

def speak(audio):                      # Speaking function
    engine.say(audio)
    engine.runAndWait()

def wishme():                          # Wishes you based on current time
    hour = int(datetime.datetime.now().hour)
    if hour >= 0 and hour<12:
        speak("Good Morning sir!")
    
    elif hour>=12 and hour < 18:
        speak("Good Afternoon sir!")

    else:
        speak("Good Evening sir!")

    speak("Hello sir myself jarvis. what can i do for you!")

def takeCommand():
    #takes microphone input and returns string output
    r = sr.Recognizer()
    with sr.Microphone() as source: 
         print("Listening...")
         r.pause_threshold = 1  # pause threshold between taking voice input
         audio = r.listen(source)
    try:
        print("Recognizing...")
        query = r.recognize_google(audio, language='en-in') # Selecting English(Indian) language
        print(f"User said: {query}\n")

    except Exception as e:
        print("Something went wrong, please try again :(")
        speak("Something went wrong, please try again")
        return "None"
    return query

if __name__ == "__main__":
    wishme()
    while True:                        # Infinite Loop with necessary break statements
        query = takeCommand().lower()  # Command stored in query variable
    
        '''
        several words in single quotes('') below in conditional statements are the keywords 
        when used in query performs a specific task assigned to them 
        
        '''

    
        if 'wikipedia' in query:       
            speak('Searching wikipedia..')
            query = query.replace("Wikipedia","")
            results = wikipedia.summary(query, 2)
            speak("According to wikipedia")
            print(results)
            speak(results)
        
        elif 'open google' in query:
            speak("opening google")
            webbrowser.open("https://google.com")
            break

        elif 'open youtube' in query:
            speak("opening youtube")
            webbrowser.open("https://youtube.com")
            break

        elif 'stackoverflow' in query:
            webbrowser.open("https://stackoverflow.com")
            break

        elif 'play' in query:
            song = query.replace('play','')
            speak('playing' + song)
            pywhatkit.playonyt(song)
            break

        elif 'time' in query:
            time = datetime.datetime.now().strftime("%I:%M %p")
            speak("Currently its" + time)
            print(time)

        elif 'joke' in query:
           speak(pyjokes.get_joke())

        elif 'exit' in query:
            break
           
