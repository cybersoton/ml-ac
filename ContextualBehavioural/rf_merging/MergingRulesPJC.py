import sys
from TableEntryPJC import TableEntryPJC
from Rule import Rule
from Expression import Expression
from Utility import satisfiesrule

import sys

wsc_max = 0
wsc_min = 1
wsc_avg = 2

cac_max = 0
cac_min = 1


# *
# A decision table is an alternative way of representing a decision tree.
# Each path from the top of the tree to the leaves defines a decision region,
# represented as a row in the decision table. Columns specify the class, weight
# and set of values of each variable.
def pjcconversion(rls, ds, F):
    w = [] 
    tot = len(ds)

    for i in range(len(rls)):
        cnt = 0
        for o in ds:
            if satisfiesrule(rls[i], o, F) == 1:
                cnt = cnt + 1
        w.append(cnt / tot)
    return w


# *
# is a sub-process to calculate the cross-product regions of two decision table,
# resulting in a decision table for the merged model. The merged model has the
# variables of both models. For each pair of regions, the set of values of each
# variable is intersected. The resulting merged region contains all the intersection
# sets relative to each variable. The intersected merged model is the set of all merged regions.
#
# rlsi: i-th dt rules set
# wi: weights associated to the regions defined by the i-th dt rules set
# wsc: criterion for the selection of the weight of a resulting region
# cac: criterion for the assignment of the class to a resulting region
def pjcintersection(rls1, w1, rls2, w2, ds, wsc, cac, F, fd):
    mrls = []  

    for i in range(len(rls1)):
        for j in range(len(rls2)):

            newantec = []
            noint = 0
            for f in F:
                ai = rls1[i].searchantec(f) 
                aj = rls2[j].searchantec(f)


                newc, outcome = getintersection(ai, aj, f, fd[f])
                if outcome == 0:
                    noint = 1

                newantec.extend(newc)

            newrl = None
            wij = getweight(w1[i], w2[j], wsc)
            cij = assignclass(w1[i], w2[j], rls1[i].cons, rls2[j].cons, cac)

            if noint == 1:
                newrl = Rule([], cij)
                noint = 0
            else:
                newrl = Rule(newantec, cij)

            entry = TableEntryPJC(rls1[i], w1[i], rls2[j], w2[j], newrl, wij)
            mrls.append(entry)

    return mrls

    self


# is the sub-process to remove disjoint regions from the intersected merged model yielding
# the filtered merged model. Disjoint regions have to be removed because they relate to
# pairs of regions of the original models that have no values in common on at least one
# variable present in both. Removing regions implies recalculating the weight of each
# region that remains to obtain a total of 100%.
#
# mrls: list of TableEntryPJC
def pjcfiltering(mrls):
    pass


# is a sub-process to limit the number of regions in the filtered merged model,
# to obtain a simpler model. The regions are examined to find out which can be merged.
# This is possible when a set of regions have the same class and all variables
# have equal values except for one. In the case of nominal variables, reduction
# consists on the union of values of that variable from all regions.
# In the case of numerical variables, currently reduction is only performed if the intervals
# are contiguous (this procedure will be improved to allow reduction even with non-contiguous intervals).
#
# mrls: list of TableEntryPJC
def pjcreduction(mrls):
    pass


# computes the intersection between two regions depending on a given feature
# ai: contains all the conditions involving the given feature, for the i-th rule
#
# Returns:
# 0: if the feature does not occur in any of the two rules
# 1: if the feature occurs in one rule only
# 2: is there exist an overlap
def getintersection(ai, aj, f, ftype):
    if ai == [] and aj == []: 
        return [], 3

    if ai == [] and aj != []: 
        return aj, 1

    if ai != [] and aj == []: 
        return ai, 1

    aij = []
    if ftype == 1: 
        rngi, infoi = buildrange(ai)
        rngj, infoj = buildrange(aj)


        aij = checkranges(rngi, rngj, infoi, infoj, f)
        if len(aij) == 0:
            aij = checkranges(rngj, rngi, infoj, infoi, f)
            if len(aij) == 0:
                return [], 0

    return aij, 2


# it builds an interval defined by the conditions in ai
def buildrange(ai):
    rngi = [sys.float_info.min, sys.float_info.max] 
    infoi = ["-", "-"] 
    for c in ai:
        if c.o == ">":
            if rngi[0] == sys.float_info.min:
                rngi[0] = c.v
                infoi[0] = "e"
            elif c.v > rngi[0]:
                rngi[0] = c.v
                infoi[0] = "e"
        elif c.o == ">=":
            if rngi[0] == sys.float_info.min:
                rngi[0] = c.v
                infoi[0] = "i"
            elif c.v >= rngi[0]:
                rngi[0] = c.v
                infoi[0] = "i"
        elif c.o == "<":
            if rngi[1] == sys.float_info.max:
                rngi[1] = c.v
                infoi[1] = "e"
            elif c.v < rngi[1]:
                rngi[1] = c.v
                infoi[1] = "e"
        elif c.o == "<=":
            if rngi[1] == sys.float_info.max:
                rngi[1] = c.v
                infoi[1] = "i"
            elif c.v <= rngi[1]:
                rngi[1] = c.v
                infoi[1] = "i"
    return rngi, infoi


def checkranges(rngi, rngj, infoi, infoj, f):
    antec = []
    if rngi[1] <= rngj[0] or rngj[1] <= rngi[0]:
        return antec

    if rngi[1] <= rngj[1] and rngi[0] >= rngj[0]:
        op = ""
        if rngi[0] != sys.float_info.min: 
            if infoi[0] == "i":
                op = ">="
            else:
                op = ">"
            exp0 = Expression(f, op, rngi[0])
            antec.append(exp0)
        if rngi[1] != sys.float_info.max: 
            if infoi[1] == "i":
                op = "<="
            else:
                op = "<"
            exp1 = Expression(f, op, rngi[1])
            antec.append(exp1)
    elif rngi[0] >= rngj[0]: 
        op = ""
        if rngi[0] != sys.float_info.min: 
            if infoi[0] == "i":
                op = ">="
            else:
                op = ">"
            exp0 = Expression(f, op, rngi[0])
            antec.append(exp0)

        if rngj[1] != sys.float_info.max:  
            if infoj[1] == "i":
                op = "<="
            else:
                op = "<"
            exp1 = Expression(f, op, rngj[1])
            antec.append(exp1)
    elif rngi[1] <= rngj[1]: 
        if rngi[1] != sys.float_info.max: 
            if infoi[1] == "i":
                op = "<="
            else:
                op = "<"
            exp1 = Expression(f, op, rngi[1])
            antec.append(exp1)

        if rngj[0] != sys.float_info.min:
            if infoj[0] == "i":
                op = ">="
            else:
                op = ">"
            exp0 = Expression(f, op, rngj[0])
            antec.append(exp0)

    return antec


def getweight(wi, wj, wsc):
    if wsc == wsc_max:
        return max([wi, wj])
    elif wsc == wsc_min:
        return min([wi, wj])
    return (wi + wj) / 2.0


def assignclass(wi, wj, ci, cj, cac):
    if cac == cac_min:
        if wi == min([wi, wj]):
            return ci
        else:
            return cj

    if wi == max([wi, wj]):
        return ci
    return cj


# *
def extractpjcrules(table):
    newrules = []
    vist = []

    for i in table:
        if len(i.rlij.antec) != 0:
            newrules.append(i.rlij)
            if i.rli not in vist:  
                vist.append(i.rli)
            if i.rlj not in vist:
                vist.append(i.rlj)

    # nota bene:
    # ogni singola regola essere state coinvolte in almeno una fusione
    # e di conseguenza queste non verranno mai trovate nel codice che segue
    # una regola occorre nel codice che segue solamente se non e mai stata
    # coinvolta in alcuna fusione

    # print( str( len(vist)))
    # print("stampa dei pesi:\n")
    for i in table:
        if len(i.rlij.antec) == 0:
            if i.rli not in vist and i.rli not in newrules:
                newrules.append(i.rli)
                print("i: " + str(i.wi) + "\n")
            if i.rlj not in vist and i.rlj not in newrules:
                newrules.append(i.rlj)
                print("j: " + str(i.wj) + "\n")

    return newrules
