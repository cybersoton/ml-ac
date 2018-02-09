class Expression:
    def __init__(self, f, o, v):
        self.f = f  # feature
        self.o = o  # operand
        self.v = v  # value (threshold)

    def __str__(self):
        return str(self.f) + " " + str(self.o) + " " + str(self.v)

    def __eq__(self, other):
        return self.__dict__ == other.__dict__
