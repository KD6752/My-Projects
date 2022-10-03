"""
NAME: Kokil Dhakal
Source: https://runestone.academy/ns/books/published/thinkcspy/IntroRecursion/toctree.html
        https://www.w3schools.com/python/python_sets.asp
Collaborator:None
Extension:No

"""


def neighbor_sum(a_list):
    list_of_sum = []
    if len(a_list) == 0:
        return []
    elif len(a_list) == 1:
        return a_list
    elif len(a_list) == 2:
        return [a_list[0] + a_list[1], a_list[-2] + a_list[-1]]
    else:
        # adding first item in the list
        list_of_sum.append(a_list[0] + a_list[1])
        # iterating over 2nd to second last item in the list
        # for first and last item done outside loop

        i = 1
        while i < len(a_list) - 1:
            list_of_sum.append(a_list[i - 1] + a_list[i] + a_list[i + 1])
            i += 1
            # last item of the a_list
        list_of_sum.append(a_list[-2] + a_list[-1])

    return list_of_sum


def get_tax(income):
    income = (income - 12550)

    tax = 0
    if income < 0:
        return 0
    elif income <= 9950:
        return income * 0.1

    else:

        if income < 40526:
            tax = (income - 9950) * 0.12 + 9950 * 0.1
        else:
            if income < 86376:
                tax = (income - 40525) * 0.22 + 9950 * 0.1 + (40525 - 9950) * 0.12
            else:
                if income < 164926:
                    tax = (income - 86375) * 0.24 + 9950 * 0.1 + (40525 - 9950) * 0.12 + (86375 - 40525) * 0.22
                else:
                    if income < 209426:
                        tax = (income - 164925) * 0.32 + 9950 * 0.1 + (40525 - 9950) * 0.12 + (86375 - 40525) * 0.22 + (
                                164925 - 86375) * 0.24
                    else:
                        if income < 523601:
                            tax = (income - 209425) * 0.35 + 9950 * 0.1 + (40525 - 9950) * 0.12 + \
                                  (86375 - 40525) * 0.22 + (164925 - 86375) * 0.24 + (
                                          209425 - 164925) * 0.32

                        else:

                            tax = (income - 523600) * 0.37 + 9950 * 0.1 + (40525 - 9950) * 0.12 + \
                                  (86375 - 40525) * 0.22 + (164925 - 86375) * 0.24 + (
                                          209425 - 164925) * 0.32 + (
                                          523600 - 209425) * 0.35

    return tax


def get_income_tax(list_of_incomes):
    list_of_income_tax = [get_tax(income) for income in list_of_incomes]
    return list_of_income_tax


class SetSuite:
    def __init__(self, list_of_list):
        self.list_of_list = list_of_list
        # in this method, for loop goes over each of lists and convert each list to set  make sets of list and then
        # saves as list_of_sets

        self.list_of_sets = [set(list1) for list1 in list_of_list]

    def add_set(self, a_list):
        self.a_list = a_list
        # this will convert input list to set and append to sets of list
        self.list_of_list.append(self.a_list)

    def get_sets(self):
        # at this method, for loop goes over each set and convert set to list that will make lists of list
        return [set(set1) for set1 in self.list_of_list]

    def union_all(self):
        # this method use union of all four sets  and return as list of items
        return set().union(*self.list_of_sets)

    def intersection_all(self):
        # using intersection rule of set to get only common element of all sets  and return as list of items
        return set.intersection(*self.list_of_sets)


obj = SetSuite(list_of_list=[[12, 15], [4, 12, 52], [4, 12, 20, 90], [6, 12, 33, 40]])
obj.add_set(a_list=[1, 2, 3, 12])
print(obj.list_of_list)
print(obj.get_sets())
print(obj.list_of_sets)
print(obj.union_all())
print(obj.intersection_all())


def perfect_power(num_1, num_2):
    # n as a counter will find how many times num2 has to divide before getting num_2 1
    global n
    n += 1
    try:
        if num_2 < num_1:
            if num_2 == 1:
                return True
            else:
                return False
        else:
            return perfect_power(num_1, num_2 / num_1)
    except RecursionError:
        print("please  do not enter 1 for numb_1  ")


n = 0
print(perfect_power(2, 2))


def pascal(row):
    if row == 0:
        return [1]
    elif row == 1:
        return [1, 1]
    else:
        # i will be using recursion in number between 2 1's. two 1's are being added before and after completion of
        # recursion
        new_row = []
        last_row = pascal(row - 1)
        for i in range(len(last_row) - 1):  # going through each of the element of last row
            new_row.append(last_row[i] + last_row[i + 1])  # adding up neighbor items from last  row
    return [1] + new_row + [1]


def convert_to_10(number, base):
    try:
        if base == 2:
            for i in number:
                if int(i) >= 2:
                    raise Exception("Error: Invalid Number")
        elif base == 3:
            for i in number:
                if int(i) >= 3:
                    raise Exception("Error: Invalid Number")

        elif base == 4:
            for i in number:
                if int(i) >= 4:
                    raise Exception("Error: Invalid Number")

        elif base == 5:
            for i in number:
                if int(i) >= 5:
                    raise Exception("Error: Invalid Number")

        elif base == 6:
            for i in number:
                if int(i) >= 6:
                    raise Exception("Error: Invalid Number")

        elif base == 7:
            for i in number:
                if int(i) >= 7:
                    raise Exception("Error: Invalid Number")
        elif base == 8:
            for i in number:
                if int(i) >= 8:
                    raise Exception("Error: Invalid Number")
        elif base == 9:
            for i in number:
                if int(i) >= 9:
                    raise Exception("Error: Invalid Number")

        if type(base) == float:
            raise FloatingPointError ("Error: Invalid Base")

        if type(base) == str:
            raise TypeError("Error: Not A Number")

        if not number.isnumeric():
            raise ValueError("Error: Not a Number")

        n = len(number)
        if n == 1:
            return int(number)
        else:
            return int(number[0]) * base ** (n - 1) + convert_to_10(number[1:], base)
    except FloatingPointError:
        return "Invalid Base"
    except TypeError:
        return "Not A Number"
    except ValueError:
        return "Not a Number"
    except Exception:
        return "Invalid Number"


print(convert_to_10("125", 1.5))


