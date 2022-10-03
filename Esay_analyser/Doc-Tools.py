import math
import re

# import matplotlib.pyplot as plt

"""
Name:Kokil Dhakal
Sources: https://stackoverflow.com/questions/47960190/sorting-dictionary-keys-for-the-equal-values
Colaborator :None
Extension:None
"""


class DocTools:

    # Category 1: Provided Methods
    def __init__(self, document):
        self.list_of_paragraphs = None
        self.sentence_terminators = ['.', '?', '!']
        self.punctuation = ['.', '?', '!', ',', ';', ':']
        self.common_words = ["as", "i", "his", "that", "he", "was", "for", "on", "are", "with", "they", "be", "at",
                             "one", "have", "this", "from",
                             "by", "hot", "word", "but", "what", "some", "is", "it", "you", "or", "had", "the", "of",
                             "to", "and", "a", "in", "we"]

        self.load_document(document)

        # Suggested Variables

        # self.list_of_words = None
        # self.list_of_lowercase_words = None
        # self.list_of_sentences = None

        # self.process_document()

    def load_document(self, file_name):
        """
        Read a file and create list of paragraphs
        :param file_name: name of file in the project (or full path to the file)
        """
        reader = open('doc1.txt', 'r')
        list_of_paras = []
        for line in reader:
            list_of_paras.append(line.rstrip())
            return line.rstrip()
        self.list_of_paragraphs = list_of_paras
        return list_of_paras

    # Category 2: Basic Stats
    def word_count(self):
        """
        Get current documents word count
        :return: number of words in essay
        """
        with open("doc1.txt") as file:
            data = file.read().split()
            return len(data)

    def character_count(self):
        """
        Get current documents character count (include all characters except new line characters)
        :return: number of characters in essay
        """
        reader = open("doc1.txt", 'r')
        list_of_paras = []  # list of paragraph counter
        count = 0  # character counter
        for line in reader:
            list_of_paras.append(line.rstrip())

        for words in list_of_paras:
            for char in words:
                count += len(char)
        return count

    def sentence_count(self):
        """
        Get current documents sentence count
        :return: number of sentences in essay
        """
        with open("doc1.txt") as file:
            data = file.read()
            # total count of sentences will be total sentences that ends with sentence terminators
            total_counts = data.count(".") + data.count("!") + data.count("?")
            return total_counts

    # Category 3: Essay Analysis
    def longest_word(self):
        """
        Get the longest word used in the document and length.
        Return a list of words with the same length
        :return: ([words], length)
        """
        with open("doc1.txt") as file:
            data = file.read()
            length_of_words = 0
            file.close()
            for ch in self.punctuation:
                data = data.replace(ch, " ")  # replacing characters with empty string
            list_of_words = data.split()  # splinting text into words by empty strings
            longest_word = ''
            length_of_longest_word = 0
            for word in list_of_words:
                if len(word) > length_of_longest_word:
                    length_of_longest_word = len(word)
            list_of_longest_word = [word for word in list_of_words if len(word) == length_of_longest_word]
            return list_of_longest_word, length_of_longest_word

    def average_word_length(self):
        """
        Get the average length of words used in the document
        :return: average length rounded to 2 decimals
        """
        with open("doc1.txt") as file:
            data = file.read()
            length_of_words = 0  # conter for total lenth of the words
            file.close()
            for ch in self.punctuation:
                data = data.replace(ch, " ")  # replacing characters with empty string
            list_of_words = data.split()  # splinting text into words by empty strings
            for word in list_of_words:
                length_of_words += len(word)
            # average of length is total length of words divide by total number of words

        return round(length_of_words / len(list_of_words), 2)

    def average_sentence_length(self):
        """
        Get the average length of sentences used in the document (measured in words)
        :return: average length rounded to 2 decimals
        """
        # with open("doc1.txt") as file:
        #     data = file.read().rstrip()
        #     terminator = ['?', '!']
        #     for ch in terminator:
        #         data1 = data.replace(ch, ".")
        #     sentences = data1.split('.')
        #     list_of_sentences = list(filter(None, sentences))
        return round(self.word_count() / self.sentence_count(), 2)

    def longest_sentence(self):
        """
        Get the longest sentence and lenth of sentence in the document
        Return a list of sentneces with the same length
        :return: ([sentences], length)
        """
        with open("doc1.txt") as file:
            # first i am converting all terminator character to one type i.e period
            data = file.read().rstrip()
            terminator = ['?', '!']
            for ch in terminator:
                data1 = data.replace(ch, ".")
            sentences = list(data1.rstrip().split('.'))  # and splitting sentences by period

        # there will be a empty string because of last period which will be removed by filter method
        list_of_sentences = list(filter(None, sentences))
        list_of_len = []  # this will have list of length of each sentences
        for sentence in list_of_sentences:
            list_of_word = sentence.split()  # list of words in each sentences
            list_of_len.append(len(list_of_word))
        # now finding the sentence with highest length
        length_longest_sentence = 0
        # length_longest_sentence = [length for length in list_of_len if length>lenght_longest_sentence]
        for length in list_of_len:
            if length > length_longest_sentence:
                length_longest_sentence = length

        # finding longest sentences
        list_of_longest_sentences = [sent.lstrip() for sent in list_of_sentences if
                                     len(sent.split()) == length_longest_sentence]
        return list_of_longest_sentences, length_longest_sentence

    def shortest_sentence(self):

        """Get the shortest sentence and lenth of sentence in the document
        Return a list of sentneces with the same length
        :return: ([sentences], length)"""
        # i used the similar method as in longest sentence
        with open("doc1.txt") as file:
            # first i am converting all terminator character to one type i.e period
            data = file.read().rstrip()
            terminator = ['?', '!']
            for ch in terminator:
                data1 = data.replace(ch, ".")
            sentences = list(data1.rstrip().split('.'))  # and splitting sentences by period
            print(sentences)

            # there will be a empty string because of last period which will be removed by filter method

        list_of_sentences = list(filter(None, sentences))
        list_of_len = []  # this will have list of length of each sentences
        for sentence in list_of_sentences:
            list_of_word = sentence.split()  # list of words in each sentences
            list_of_len.append(len(list_of_word))

        length_shortest_sentence = list_of_len[0]  # conter for shortest sentence length

        for number in list_of_len:
            if number < length_shortest_sentence:
                length_shortest_sentence = number

            # finding shortest sentences

        list_of_shortest_sentences = [sent.lstrip() for sent in list_of_sentences if
                                      len(sent.split()) == length_shortest_sentence]
        return list_of_shortest_sentences, length_shortest_sentence

    def most_frequent_words(self, n):
        """
        Get the n most frequent words from the document (ignore capitilization and punctuiation).
        Ignore all words in the ignore_list
        You may break ties in any way.
        :param n: Number of words to return
        :return: List of most frequent words in order
        """
        with open("doc1.txt") as file:
            data = file.read()
            length_of_words = 0
            file.close()
            for ch in self.punctuation:
                data = data.replace(ch, " ")  # replacing characters with empty string
        list_of_words = data.split()  # splinting text into words by empty strings
        dictionary = {}
        for word in list_of_words:
            if word.lower() in dictionary.keys():
                dictionary[word.lower()] += 1
            else:
                dictionary[word.lower()] = 1
        # getting rid of common words
        for word1 in self.common_words:
            if word1 in dictionary.keys():
                dictionary.pop(word1)
        # sorting dictionary based on their count
        sorted_tuples = sorted(dictionary.items(), key=lambda item: item[1], reverse=True)
        # converting sorted tuples back to dictionary
        sorted_dictionary = dict((x, y) for x, y in sorted_tuples)
        # sorting keys alphabetically if their value are equal
        dict_sorted_key = dict(sorted(sorted_dictionary.items(), key=lambda x: (-x[1], x[0])))
        # dict_sorted_key = sorted(sorted_dictionary.items(), key=lambda t: t[::-1])
        list_keys = list(dict_sorted_key.keys())
        return list_keys[:n]

    def num_distinct_words(self):
        """
        Get the number of distinct words (ignore punctuation and capitalization)
        :return: Number of distinct words
        """

        # return  len(set(w.lower() for w in open("doc1.txt").read().split()))

        with open("doc1.txt") as file:
            data = file.read().split()
            file.close()
            distinct_words = set()  # set will give unique words
            for word in data:
                word = word.lower()
                listOfChar = list(word)  # making list of character present in each word
                for char in listOfChar:
                    if char in self.punctuation:
                        listOfChar.remove(char)  # removing punctuation present in each word

                listOfChar = "".join(listOfChar)
                distinct_words.add(listOfChar)
            return len(distinct_words)

            # Category 4: Tools

    def list_of_sentences(self):
        with open("doc1.txt") as file:
            # first i am converting all terminator character to one type i.e period
            data = file.read().rstrip()
            terminator = ['?', '!']
            for ch in terminator:
                data1 = data.replace(ch, ".")
                data1 = data1.lower()
            sentences = list(data1.rstrip().split('.'))  # and splitting sentences by period

        # there will be a empty string because of last period which will be removed by filter method
        list_of_sentences = list(filter(None, sentences))
        return list_of_sentences

    def find_word(self, word1):
        """
        Find all the positions of a word (like 5th word in essay should return 5 NOT 4) and the sentence it is a part of.
        (ignore punctuation and capitalization)
        :param word: word to search for
        :return: List of positions and list of sentences
        """
        with open("doc1.txt") as file:
            data = file.read().split()
            file.close()
            list_words = []  # set will give unique words
            for word in data:
                word = word.lower()
                listOfChar = list(word)  # making list of character present in each word
                for char in listOfChar:
                    if char in self.punctuation:
                        listOfChar.remove(char)  # removing punctuation present in each word

                listOfChar = "".join(listOfChar)
                list_words.append(listOfChar)
            # print(list_words)
            indices = [i + 1 for i, x in enumerate(list_words) if
                       x == word1]  # using list comprehension to find indexes
            # list_of_sentences = self.list_of_sentences()
            # for sentence in list_of_sentences:
            #     if word1 in sentence:
            #         print(sentence)
            return indices

    def replace_word(self, original, new):
        """
        Replace all instances of one word with new word. Maintain punctuation but do not ignore capitalization
        :param original: word to replace
        :param new: word to replace with
        :return: number of changes, list of paragraphs with changes
        """
        with open("doc1.txt") as file:
            data = file.read().split()
            file.close()
            list_words = []  # set will give unique words
            for word in data:
                listOfChar = list(word)  # making list of character present in each word
                for char in listOfChar:
                    if char in self.punctuation:
                        listOfChar.remove(char)  # removing punctuation present in each word

                listOfChar = "".join(listOfChar)
                list_words.append(listOfChar)
            # finding number of words  already present in the list of word(words same as new word)
            count_change_word = 0
            for w in list_words:
                if w == new:
                    count_change_word += 1
            # now replacing the original word with new word
            for word in list_words:
                if word == original:
                    index_of_word = list_words.index(word)
                    list_words[index_of_word] = new
            # Total number of new and old words present e.g number of injustice before replacing plus numbers after
            # replacing with justice
            count_change_word1 = 0
            for w in list_words:
                if w == new:
                    count_change_word1 += 1
            # this is the actual number of word replaced.
            return count_change_word1 - count_change_word

    def spell_check(self):
        """
        Use dictionary.txt to check for correct spelling of words. Ignore punctuation and capitalization.
        :return: (number_wrong, [indices])
        """
        words = open('dictionary.txt').readlines()
        words_in_dictionary = [word.strip() for word in words]
        with open("doc1.txt") as file:
            data = file.read().split()
            file.close()
            list_words = []  # set will give unique words
            for word in data:
                listOfChar = list(word)  # making list of character present in each word
                for char in listOfChar:
                    if char in self.punctuation:
                        listOfChar.remove(char)  # removing punctuation present in each word

                listOfChar = "".join(listOfChar)
                list_words.append(listOfChar)
        # list_of_index = []  # list of index counter
        # now checking each of the word present in the document in the dictionary.txt file
        # and if not present, get indexes.

            list_of_index = [i+1 for i, x in enumerate(list_words) if x.lower() not in words_in_dictionary]
            # list_of_index.append(list_words.index(word1) + 1)

        return len(list_of_index), list_of_index

    def write_document(self, file_name):
        """
        Write the current document to a new file
        :param file_name:
        :return:
        """

        # Write the file out again
        pass

    # Category 5: Advanced Analysis
    def words_by_prefix(self, prefix):
        """
        Get a list of all words in the document with the prefix provided. Sort alphabetical. Ignore capitalization
        :param prefix:
        :return:
        """
        with open("doc1.txt") as file:
            data = file.read().split()
            file.close()
            list_of_words = []
            for word in data:
                if word.startswith(prefix):  # using startswith method
                    list_of_words.append(word)
        return sorted(list_of_words)

    def character_fingerprint(self):
        """
        Generate a character fingerprint dictionary of letters (ignoring capitalization)
        Do not include any non-letter characters (only a-z)
        show plot using matplotlib and include in your README
        :return: dictionary finger_print of letters with their counts
        """
        with open("doc1.txt") as file:
            data = file.read().split()
            file.close()
            list_of_char = []  # list of char present in text including punctuations
            for words in data:
                for char in words:
                    list_of_char.append(char.lower())
            # making list that has only a-z letters present in document
            list_letter = [char for char in list_of_char if char.isalpha()]
            dict_of_letter = {}
            for char in list_letter:
                if char in dict_of_letter:
                    dict_of_letter[char] += 1

                else:
                    dict_of_letter[char] = 1

            sorted_tuples = sorted(dict_of_letter.items())  # sorted tuples based on alphabetical order of key
            dict_of_of_sorted_letter = dict((x, y) for x, y in sorted_tuples)  # converting tuples back to dictionary
            return dict_of_of_sorted_letter
            # alphabets = dict_of_of_sorted_letter.keys()
            # count_of_alphabets = dict_of_of_sorted_letter.values()
            # list_of_percentage = [count / sum(count_of_alphabets)*100 for count in count_of_alphabets]
            #
            # plt.bar(alphabets, list_of_percentage)
            # plt.xlabel("alphabets present in text")
            # plt.ylabel("frequency of letters by percentage")
            # plt.title("Letter frequency analysis")
            # plt.show()

    def auto_complete(self, input_string):
        """
        Return the top 3(at most) results as a list by current usage in the document where the input is a prefix
        Ignore capitalization.
        You may break times in any way you want.
        If there are less than 3 words with the input_string as prefix return fewer results
        :param input_string:
        :return: list of recommendations
        """
        with open("doc1.txt") as file:
            data = file.read().split()
            file.close()
            list_of_words = []  # set will give unique words
            for word in data:
                word = word.lower()
                listOfChar = list(word)  # making list of character present in each word
                for char in listOfChar:
                    if char in self.punctuation:
                        listOfChar.remove(char)  # removing punctuation present in each word

                listOfChar = "".join(listOfChar)
                list_of_words.append(listOfChar)
        # making another list of  words that starts with the prefix
        sorted_list = []
        for word in list_of_words:
            if word.startswith(input_string):
                sorted_list.append(word)
        dict_word = {}
        # counting each of the words and sorting words based on their frequency in text. if frequency are equal, sort
        # them alphabetically
        for word in sorted_list:
            if word.lower() in dict_word.keys():
                dict_word[word.lower()] += 1
            else:
                dict_word[word.lower()] = 1
        # sorting dictionary as key value tupple
        sorted_tuples = sorted(dict_word.items(), key=lambda item: item[1], reverse=True)
        # making dictionary again from sorted tuples
        sorted_dictionary = dict((x, y) for x, y in sorted_tuples)
        # sorting keys alphabetically if their value are equal
        dict_sorted_key = dict(sorted(sorted_dictionary.items(), key=lambda x: (-x[1], x[0])))
        # taking out keys from dictionary
        list_keys = list(dict_sorted_key.keys())
        return list_keys[:3]

    # def print_stats(self):
    #     """
    #     Print all stats
    #     :return:
    #     """
    #     print("-----Category 2: Basic Stats-----")
    #     print('Word Count')
    #     print(self.word_count())
    #     print('Character Count')
    #     print(self.character_count())
    #     print('Sentence Count')
    #     print(self.sentence_count())
    #
    #     print("-----Category 3: Essay Analysis-----")
    #     print('Longest Word')
    #     print(self.longest_word())
    #     print('Average Word Length')
    #     print(self.average_word_length())
    #     print('Average Sentence Length')
    #     print(self.average_sentence_length())
    #     print('Longest Sentence')
    #     print(self.longest_sentence())
    #     print('Shortest Sentence')
    #     print(self.shortest_sentence())
    #     print('Most Frequent 5 Interesting Words')
    #     print(self.most_frequent_words(5))
    #     print('Number of Unique Words')
    #     print(self.num_distinct_words())
    #
    #     print("-----Category 4: Advanced Analysis-----")
    #     print('Character Fingerprint')
    #     print(self.character_fingerprint())
    #     print('Words with prefix "re"')
    #     print(self.words_by_prefix('re'))
    #     print('Auto Complete for "in"')
    #     print(self.auto_complete("in"))
    #     print('Auto Complete for "rec"')
    #     print(self.auto_complete("rec"))
    #
    # def tool_test(self):
    #     print('-----Category 5: Testing Tools-----')
    #     print('Find word justice')
    #     print(self.find_word('justice'))
    #     print('Replace Justice with bloated')
    #     print(self.replace_word('justice', 'bloated'))
    #     print('New: ', self.list_of_paragraphs)
    #     print('Spell Check')
    #     print(self.spell_check())
    #     print('Save')
    #     self.write_document('result.txt')


    #


# Testing Zone

# Initialize the tool
tools = DocTools('doc1.txt')

# For local testing (not how your code will be run, but is similar)
# tools.print_stats()
# tools.tool_test()
# tools.load_document('doc1.txt')
# print(tools.list_of_paragraphs)
# print(tools.average_word_length())
# print(tools.average_sentence_length())
# print(tools.word_count())
# print(tools.longest_sentence())
# print(tools.shortest_sentence())
# print(tools.most_frequent_words(5))
# print(tools.num_distinct_words())
# print(tools.words_by_prefix("re"))
# print(tools.character_fingerprint())
# print(tools.find_word('justice'))
# print(tools.list_of_sentences())
# print(tools.replace_word('justice', 'injustice'))
# print(tools.character_count('doc1.txt))
# # print(tools.write_document('doc1.txt'))
# print(tools.auto_complete('in'))
print(tools.spell_check())
