"""
Name:Kokil Dhakal
Source:https://www.geeksforgeeks.org/doubly-linked-list/
       https://www.w3schools.com/python/python_dictionaries.asp
       https://towardsdatascience.com/how-to-implement-merge-sort-algorithm-in-python-4662a89ae48c
Collaborator:None
Extension:None
"""

class Node:
    def __init__(self, value):
        self.value = value
        self.prev = None
        self.next = None

    def get_prev(self):
        return self.prev

    def get_next(self):
        return self.next

    def get_value(self):
        return self.value

    def set_prev(self, node):
        self.prev = node.prev

    def set_next(self, node):
        self.next = node.next

    def set_value(self, val):
        self.value = val


class DoublyLinkedList:
    def __init__(self):
        self.head = None

    def print_dll(self):
        if self.head is None:
            print("empty list")
            return
        else:
            current = self.head
            while current is not None:
                print(current.value, " ")
                current = current.next

    def add_to_end(self, val):
        if self.head is None:  # if list is empty, new list of one node will be formed
            new_node = Node(val)
            self.head = new_node
            return
        current = self.head
        # if  if list has one or more nodes, we traverse over all node until last node found.
        while current.next is not None:
            current = current.next
        new_node = Node(val)
        current.next = new_node
        new_node.prev = current

    def add_to_front(self, val):
        if self.head is None:
            new_node = Node(val)
            self.head = new_node
            return
        else:
            new_node = Node(val)
            new_node.next = self.head
            self.head.prev = new_node
            self.head = new_node

    def delete(self, val):
        # if list is empty, it will return empty list
        if self.head is None:
            print("empty linked list")
            return
            # if linked list has only one
        if self.head.next is None:
            # if value is not equal to given value to delete
            if self.head.value != val:
                print("value not found")
            # if given value found, we will delete that value i.e making head Null
            else:
                self.head = None
            return

            # if list contain multiple values  we traverse through list and delete the item
        if self.head.value == val:  # if first item of the list is value we wanted to delete
            self.head = self.head.next  # next node will be head
            self.head.prev = None
            return

        current = self.head
        while current.next is not None:
            if current.value == val:
                break
            current = current.next
        temp1 = current.prev
        temp2 = current.next
        if current.next is not None:
            current.next.prev = current.prev
            current.prev.next = current.next

        else:
            if current.value == val:  # if last element is the value we are looking for
                current.prev.next = None
            else:
                print("val not found")

    def reverse(self):
        """
        in this method i divide whole reversing process in 3 parts, first part deals with first element of the original list
        second part deals with middle nodes except last and first and third part deals with last node of the original
        list.
        """
        if self.head is None:
            print("Empty list")
            return
        else:
            current = self.head
            temp_var = current.next  # making temporary vairable temp_var
            # reversing references of head so that prev ref of head now pointing to next self.head.next
            # next node of orig head set to None
            current.next = None
            current.prev = temp_var
            while temp_var is not None:  # working for middle part of the nodes
                temp_var.prev = temp_var.next
                temp_var.next = current
                current = temp_var
                temp_var = temp_var.prev

            self.head = current  # last part of original node set to head

    def compare(self, lst):
        index2 = 0
        index = 0  # position counter
        if self.head is None and len(lst) == 0:
            # to check whether list is empty or not
            print("Empty dll and lst")
        else:
            current = self.head
            while current is not None and index2 < len(lst):  # if not empty, go through each node and check value
                index += 1
                if current.value != lst[index2]:
                    return False  # if value found return it's position
                index2 += 1
                current = current.next

            return True

    def find(self, val):
        index = 0  # position counter
        if self.head is None:  # to check whether list is empty or not
            print("Empty linked list")
        else:
            current = self.head
            while current is not None:  # if not empty, go through each node and check value
                index += 1
                if current.value == val:
                    return index-1  # if value found return it's position1
                current = current.next
            return False  # if not found return False


# ****************************************************************************************************************
def merge_sort(lst):
    # dividing given list to  half  until each list has single integer
    # and then combining all those integers  while sorting
    if len(lst) > 1:
        mid = len(lst) // 2  # finding middle index of the list
        left_list = lst[:mid]
        right_list = lst[mid:]
        # now i will use recursion to each of list to get list of single number
        merge_sort(left_list)
        merge_sort(right_list)
        # three indexes x,y and z that goes over left_list, right_list and original list respectively
        x = y = z = 0
        while x < len(left_list) and y < len(right_list):
            if left_list[x] < right_list[y]:
                lst[z] = left_list[x]
                # next index in left list
                x += 1
            else:
                lst[z] = right_list[y]
                # next index in right list
                y += 1
            # next index in original list
            z += 1
        # for all remaining values
        while x < len(left_list):
            lst[z] = left_list[x]
            x += 1
            z += 1
        while y < len(right_list):
            lst[z] = right_list[y]
            y += 1
            z += 1

    return lst


print(merge_sort([3, 1, 4, 5, 7, 2]))


# *********************************************************************************************************************
def lst_to_dict(lst, start, end):
    # Big O notation for this function is O(N)
    # first getting keys
    list_of_keys = range(start, end + 1)
    # second getting list of values for  key
    list_of_values = []
    for key in list_of_keys:
        # checking if key generated from number between start and end point in lst
        if key in lst:
            values = lst.index(key)
        else:
            values = None

        list_of_values.append(values)
    # making dictionary from keys and values
    dictionary = dict(zip(list_of_keys, list_of_values))

    return dictionary


print(lst_to_dict([3, 5, 6, 2, 8, 9], 0, 9))


# *********************************************************************************************************************
def target_sum(lst, target):
    """ Getting two numbers from the list that add up to target number. for this I used two iterator i and j which
    go over list.out of many combinations between i and j to add up. we just need numbers that add up to target number.
    For this i used if condition. after  finding numbers, i returs respective indices in increasing order. I used two
    nested loop for this which are the dominant term that is why big O notation for this is O(N^2)
    """
    for i in lst:
        for j in lst:

            if i + j == target and lst.index(i) < lst.index(j):
                return lst.index(i), lst.index(j)

            elif i + j == target and lst.index(i) > lst.index(j):
                return lst.index(j), lst.index(i)


#
print(target_sum([1, 2, 3, 5, 9, 15], 7))

# **********************************************************************************************************************
