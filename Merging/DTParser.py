from .Rule import Rule
from .Expression import Expression


# It parses the output produced by a decision tree implemented in Matlab.
# The output format is reported to below:
# id  if X<V_x then node id_x elseif Y>=V_y then node id_y else 1
# id  class = lab
# NB: The ID of each statement must not be preceded by any leading space character
def parsedt(path):
    src = open(path, "r")

    dts = []
    dtstr = []

    for i in src:
        if i == "\n":
            if len(dtstr) > 0:
                dts.append(getdtrules(dtstr))
                dtstr = []
        else:
            dtstr.append(i)

    return dts


def getdtrules(dt):
    ID_IDX = 0
    IF1_IDX = 3
    ID1_IDX = 6
    IF2_IDX = 8
    ID2_IDX = 11
    CLASS_IDX = 2
    LAB_IDX = 4
    class_str = "class"
    delim = " "
    stdc = {}

    for i in dt:
        lv1tkns = i.strip('\n').split(" ")
        id = 0
        try:
            id = int(lv1tkns[ID_IDX])
        except ValueError:
            continue

        if lv1tkns[CLASS_IDX] == class_str:
            stdc[id] = lv1tkns[LAB_IDX]
        else:
            stdc[id] = lv1tkns[IF1_IDX] + delim + lv1tkns[ID1_IDX] + delim + lv1tkns[IF2_IDX] + delim + lv1tkns[ID2_IDX]


    vislst = []
    rules = []

    ids = list(stdc.keys())
    ids.sort()

    exp1, exp2 = getexprs(stdc[ids[0]])  
    vislst.extend([[Rule([exp1[0]], ""), exp1[1]],
                   [Rule([exp2[0]], ""), exp2[1]]])  

    curr = None 
    while len(vislst) > 0:
        if curr is None:
            curr = vislst[0]  
            vislst.remove(curr)  

        exp1, exp2 = getexprs(stdc[curr[1]])  
        if exp1 is None:
            curr[0].cons = stdc[curr[1]] 
            rules.append(curr[0])
            curr = None
        else:
            newant = list(curr[0].antec) 
            newant.append(exp2[0])
            newrl = Rule(newant, "")
            curr[1] = exp1[1]
            curr[0].antec.append(exp1[0]) 
            vislst.append(
                [newrl, exp2[1]]) 

    return rules


def getexprs(stat):
    tkns = stat.split(" ")
    if len(tkns) == 1:
        return None, None

    ft, op, vl = getcnd(tkns[0])
    exp1 = Expression(ft, op, vl)

    ft, op, vl = getcnd(tkns[2])
    exp2 = Expression(ft, op, vl)
    return [exp1, int(tkns[1])], [exp2, int(tkns[3])]


def getcnd(cnd):
    sp = 0
    ep = 0

    if cnd.find("<") != -1:
        sp = cnd.find("<")
        ep = sp + 1
    elif cnd.find("<=") != -1:
        sp = cnd.find("<=")
        ep = sp + 2
    elif cnd.find(">=") != -1:
        sp = cnd.find(">=")
        ep = sp + 2
    else:
        sp = cnd.find(">")
        ep = sp + 1

    ft = cnd[0:sp]
    op = cnd[sp:ep]
    vl = cnd[ep: len(cnd)]

    return ft, op, float(vl)
