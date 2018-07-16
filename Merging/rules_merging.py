import sys
from DTParser import parsedt
from Utility import readds, evalrls
from MergingRulesPJC import pjcconversion, pjcintersection, extractpjcrules, wsc_avg, \
    wsc_min, wsc_max, cac_max, cac_min

#sys.path.insert(0, os.getcwd())

if __name__ == '__main__':
    if len(sys.argv) != 5:
        print("The expected number of input parameters is wrong!")
        print("Expected: <dataset file path>, <rules file sparse>, <set file path>, <destination file path>")
        exit()

    dspath = sys.argv[1]
    rlspath = sys.argv[2]
    testpath = sys.argv[3]
    dstpath = sys.argv[4]

    print("Dataset path: " + dspath)
    print("Rules path: " + rlspath)
    rls = parsedt(rlspath)

    F = ["x1", "x2", "x3", "x4"]  # TODO: for now, the number of features is fixed
    fd = {}
    ftype = []
    for i in F:
        fd[i] = 1  # 1 stands for numerical
    for i in range(len(F)):
        ftype.append(fd[F[i]])
    ds = readds(dspath, ftype, 1)  # the last column corresponds to the class attribute
    ts = readds(testpath, ftype, 0)

    print("Total number of instances in the dataset: " + str(len(ds)))

    wscpar = wsc_avg
    cacpar = cac_max
    nexti = 0
    mrls = list(rls[nexti])
    nexti += 1

    while nexti < len(rls):
        # the rules are converted in table records
        mw = pjcconversion(mrls, ds, F)
        nxtw = pjcconversion(rls[nexti], ds, F)

        print("\nMerging of " + str(nexti - 1) + " " + str(nexti))

        table = pjcintersection(mrls, mw, rls[nexti], nxtw, ds, wscpar, cacpar, F, fd)

        mrls = extractpjcrules(table)
        nexti += 1

    dstfl = open(dstpath, "w")
    for i in mrls:
        dstfl.write(str(i))
        dstfl.write("\n")
    dstfl.close()
    print("Evaluation of the resulting rules: " + str(evalrls(mrls, ts, F, "1", "0")))
