import csv


# *
# Verifies that a given object o satisfies a given rule ri
# returns 1 if the outcome is positive, 0 otherwise
def satisfiesrule(ri, o, F):
    if len(ri.antec) == 0:
        return 0

    for c in ri.antec:
        i = F.index(c.f) 
        if c.o == ">":
            if o[i] <= c.v:
                return 0
        if c.o == ">=":
            if o[i] < c.v:
                return 0
        if c.o == "<":
            if o[i] >= c.v:
                return 0
        if c.o == "<=":
            if o[i] > c.v:
                return 0

    return 1


# *
def readds(dspath, fd, withclass):
    dst = []
    countclass = 0
    if withclass == 1:
        countclass = 1

    with open(dspath, 'r') as csvfile:
        dsrc = csv.reader(csvfile, delimiter=' ', quotechar='|')
        for i in dsrc:
            row = []
            for j in range(len(i) - countclass):
                try:
                    if fd[j] == 1:
                        val = float(i[j])
                        row.append(val)
                    else:
                        row.append(i[j])
                except ValueError:
                    row.append(i[j])

            if withclass == 1: 
                row.append(i[len(i) - 1])
            dst.append(row)
    return dst


# *
def evalrls(rls, ds, F, ci, cj):
    mism = 0
    succs = 0
    found = 0
    nrrls = 0
    cnt = 0
    for o in ds:
        for r in rls:
            if satisfiesrule(r, o, F) == 1:
                if found == 0:
                    if r.cons != o[len(o) - 1]:
                        mism += 1
                    else:
                        succs += 1

                found = 1
                nrrls += 1

        if found == 0:
            cnt += 1
        else:
            found = 0

        if nrrls > 1:
            print("trovate " + str(nrrls))
            print(o)
            print("")
        nrrls = 0

    return mism / len(ds), succs / len(ds), cnt

