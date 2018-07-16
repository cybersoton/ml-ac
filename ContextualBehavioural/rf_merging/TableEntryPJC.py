class TableEntryPJC:
    def __init__(self, rli, wi, rlj, wj, rlij, wij):
        self.rli = rli
        self.rlj = rlj
        self.rlij = rlij
        self.wi = wi
        self.wj = wj
        self.wij = wij

    def __str__(self):
        res = ""
        res = res + " " + str(self.rli) + " : " + str(self.wi) + "\n"
        res = res + " " + str(self.rlj) + " : " + str(self.wj) + "\n"
        res = res + " " + str(self.rlij) + " : " + str(self.wij) + "\n"

        return res

    def __eq__(self, other):
        return self.__dict__ == other.__dict__
