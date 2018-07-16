class Rule:
    def __init__(self, exprs, label):
        self.antec = exprs  # list of Expression
        self.cons = label

    def searchantec(self, f):
        lst = []
        for i in self.antec:
            if f == i.f:
                lst.append(i)
        return lst

    def __str__(self):
        res = ""
        for i in range(len(self.antec)):
            res = res + str(self.antec[i])
            if i < len(self.antec) - 1:
                res = res + " & "

        return res + " ==> " + str(self.cons)

    def __eq__(self, other):
        return self.__dict__ == other.__dict__
