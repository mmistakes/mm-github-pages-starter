---
title:  "Scraping flashcards for Anki with Python"
categories:
  - Blog
tags:
  - link
  - Post Formats
link: https://github.com
---

So while I am using Anki (flashcard program) to expand my
vocabulary for my upcoming GRE test (wish me luck) I came across
[this word list](https://quizlet.com/14840887/500-practice-gre-vocabulary-words-flash-cards/). 

Would it be possible to write a Python script that grabs all the words and
definitions from that website and puts them in a text file which can be imported
into Anki? Let's find out! 

So, where do we start? Let's first create a directory

    $ cd Programming/Python
    $ mkdir AnkiScrape
    $ cd AnkiScrape

For this little project I used the following libraries: BeautifulSoup4 and urllib2

    from bs4 import BeautifulSoup
    import urllib2

Alright, what do we do now? I forgot how to use BeautifulSoup (BS4) so I had to
look it up. Stack Overflow to the [rescue](http://stackoverflow.com/questions/15797861/using-beautifulsoup-and-urllib2-in-python-how-can-i-find-the-data-surrounded-by). 
The code found on Stack Overflow was given as follows

import urllib2
from bs4 import BeautifulSoup
html = urllib2.urlopen( "http://www.google.com" ).read()
soup = BeautifulSoup(html)

Modifying that we find

    from bs4 import BeautifulSoup
    import urllib2

    url = "https://quizlet.com/14840887/500-practice-gre-vocabulary-words-flash-cards/"
    content = urllib2.urlopen(url).read()
    soup = BeautifulSoup(content)

Now that we have a soup to work with, how are we going to extract the content
that we need?  Taking a quick peek in the source code of the URL shows the
following

    <span class='TermText qWord lang-en'>avatar</span>	</h3>
    <span class='TermText qDef lang-en'>(n.) the animal or human ... 

So the word is in the span class 'TermText qWord lang-en' and the definition of
the word is contained in the span class 'TermText qDef lang-en'. I admit that I
have little knowledge of HTML which just shows that you don't need to know HTML,
you just need to know what div the text is in! That is all we need to know to
retrieve it with BS4. 

How do we retrieve something from a specific span class with BS4? I will spare
you the Google query but I found this question on Stack Overflow which asks the
exact same question
[here](http://stackoverflow.com/questions/16248723/how-to-find-spans-with-a-specific-class-containing-specific-text-using-beautiful). 

Changing the code to fit our example we find 

    from bs4 import BeautifulSoup
    import urllib2

    url = "https://quizlet.com/14840887/500-practice-gre-vocabulary-words-flash-cards/"
    content = urllib2.urlopen(url).read()
    soup = BeautifulSoup(content)

    # find list of all span elements containing the words and definitions
    wordspan = soup.find_all('span', {'class' : 'TermText qWord lang-en'})
    defspan = soup.find_all('span', {'class' : 'TermText qDef lang-en'})

    # create list of lines corresponding to element texts 
    words = [span.get_text() for span in wordspan]
    defs = [span.get_text() for span in defspan]

After some research, I figured out that Anki simply accepts .txt files that are
comma and newline seperated, easy enough right? My first (probably not the most
elegant or Pythonic idea) is to zip the words and defs in a dictionary and then
print the key and according value. In hindsight, I should've just looped over
both lists with the same iterator. 

    dictionary = dict(zip(words, defs)) # zip into dict

    with open('GRE-vocab.txt','w') as out:
        for key in dictionary: 
            out.write('{0}, {1}\n'.format(key.encode('utf-8'), dictionary[key].encode('utf-8')))
            # print key.encode('utf-8'), dictionary[key].encode('utf-8'), '\n'

Which gives us the end result 

    from bs4 import BeautifulSoup
    import urllib2

    url = "https://quizlet.com/14840887/500-practice-gre-vocabulary-words-flash-cards/"
    content = urllib2.urlopen(url).read()
    soup = BeautifulSoup(content)

    # find list of all span elements containing the words and definitions
    wordspan = soup.find_all('span', {'class' : 'TermText qWord lang-en'})
    defspan = soup.find_all('span', {'class' : 'TermText qDef lang-en'})

    # create list of lines corresponding to element texts 
    words = [span.get_text() for span in wordspan]
    defs = [span.get_text() for span in defspan]

    dictionary = dict(zip(words, defs)) # zip into dict

    with open('GRE-vocab.txt','w') as out:
        for key in dictionary: 
            out.write('{0}, {1}\n'.format(key.encode('utf-8'), dictionary[key].encode('utf-8')))

Where the first 10 lines of GRE-vocab.txt are as follows

    fawn, (v.) to flatter or grovel, (v.) to seek notice or favor
    effigy, (n.) a crude person or figure which represents a hated person or ...
    surreptitious, (adj.) sly, sneaky and covert
    circumlocution, (n.) an indirect or roundabout way of speaking
    importune, (v.) to demand by means of solicitation; (v.) to make unwanted...
    umbrage, (n.) a feeling of anger, usually caused by offense; (n.) indigna...
    kleptomaniac, (n.) someone consumed by the impulsive need to steal, witho...
    sangfroid, (n.) coolness and composure, especially amidst trying and chal...
    onus, (n.) a burdensome responsibility; burden of proof
    turbid, (adj.) muddy due to sediment or foreign particles; (adj.) heavy, ...

Which can be imported into Anki to automatically create flashcards, awesome!
Mission accomplished! 


