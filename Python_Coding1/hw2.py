"""
Name:Kokil Dhakal
Source: https://appdividend.com/2022/05/30/python-list-contains/
https://www.reddit.com/r/learnpython/comments/4bm5zo/comparing_two_string_with_a_for_loop_and_breaking/
https://www.geeksforgeeks.org/program-to-add-two-binary-strings/
Contributor: no
Extension:no
"""


# Answer to problem 5

def is_leap(year):
    if year % 4 == 0 and year % 100 != 0:  # applying definition of leap year
        return True
    elif year % 400 == 0:  # applying definition of leap year
        return True
    else:
        return False


print(is_leap(1800))


# Answer to question 6
def is_triangle(num):
    list_triangle_num = []
    sum1 = 0
    for number in range(1, num + 1):
        sum1 += number
        list_triangle_num.append(sum1)
    if number in list_triangle_num:
        return True
    else:
        return False


print(is_triangle(5))


# Answer to question 7
def is_triangle(num):
    list_triangle_num = []  # list of triangle number
    sum1 = 0  # to add up number from given range
    for number in range(1, num + 1):
        sum1 += number
        list_triangle_num.append(sum1)

    if number in list_triangle_num:

        return True
    else:
        return False


def triangle_sum(lower_bound, upper_bound):
    sum2 = 0  # to add up triangle number between given range
    for number2 in range(lower_bound, upper_bound + 1):
        if is_triangle(number2) == True:
            sum2 = sum2 + number2
        else:
            continue

    return sum2


print(triangle_sum(1, 21))

# Answer to question 8
import random


def random_gen(n):
    list_random_number = []
    while True:
        if len(list_random_number) != n:
            x = random.randint(1, 9)
            list_random_number.append(x)
        else:
            break
    return list_random_number


print(random_gen(10))


# Answer to problem 9
def bit_and(a, b):
    max_len = max(len(a), len(b))  # finding maximum length between two string

    mod_a = a.zfill(max_len)  # filling string with zero to make same length
    mod_b = b.zfill(max_len)

    new_string = []  # new list will be made after adding element after bitwise And operation
    for i, j in zip(mod_a, mod_b):
        if i == "1" and j == "1":  # using bitwise And operation rule
            new_string.append(1)
        else:
            new_string.append(0)
    # converting list of 1s and 0s to base 10 number
    decimal_num = 0
    string_len = len(new_string)
    for num in new_string:
        decimal_num += num * 2 ** (string_len - 1)
        string_len = string_len - 1

    return decimal_num


print(bit_and("1001", "1001"))


# Answers to Questions10
def digit_sum(num):
    while num > 9:
        sum1 = 0
        for number in list(str(num)):
            sum1 = sum1 + int(number)

        num = sum1

    return sum1


print(digit_sum(83))
