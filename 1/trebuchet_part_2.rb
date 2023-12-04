class Trebuchet
    @@forward_map = { 
        "1" => Proc.new{1},  
        "2" => Proc.new{2},  
        "3" => Proc.new{3},  
        "4" => Proc.new{4},  
        "5" => Proc.new{5},  
        "6" => Proc.new{6},  
        "7" => Proc.new{7},  
        "8" => Proc.new{8},  
        "9" => Proc.new{9},  
        "0" => Proc.new{0},  
        "o" => Proc.new{|line, i| 1 if line.size >= i + 2 && line[i, 3] == "one"},
        "t" => Proc.new{|line, i| 
            if line.size >= i + 2 && line[i, 3] == "two"
                2
            elsif line.size >= i + 4 && line[i, 5] == "three"
                3
            end},
        "f" => Proc.new{|line, i| 
            if line.size >= i + 3 && line[i, 4] == "four"
                4
            elsif line.size >= i + 3 && line[i, 4] == "five"
                5
            end},
        "s" => Proc.new{|line, i| 
            if line.size >= i + 2 && line[i, 3] == "six"
                6
            elsif line.size >= i + 4 && line[i, 5] == "seven"
                7
            end},
        "e" => Proc.new{|line, i| 8 if line.size >= i + 4 && line[i, 5] == "eight"},
        "n" => Proc.new{|line, i| 9 if line.size >= i + 3 && line[i, 4] == "nine"},
    }

    @@back_map = { 
        "1" => Proc.new{1},  
        "2" => Proc.new{2},  
        "3" => Proc.new{3},  
        "4" => Proc.new{4},  
        "5" => Proc.new{5},  
        "6" => Proc.new{6},  
        "7" => Proc.new{7},  
        "8" => Proc.new{8},  
        "9" => Proc.new{9},  
        "0" => Proc.new{0},  
        "e" => Proc.new{|line, i| 
            if i >= 2 && line[i-2, 3] == "one"
                1
            elsif i >= 4 && line[i-4, 5] == "three"
                3
            elsif i >= 3 && line[i-3, 4] == "five"
                5
            elsif i >= 3 && line[i-3, 4] == "nine"
                9
            end},
        "o" => Proc.new{|line, i| 2 if i >= 2 && line[i-2, 3] == "two"},
        "r" => Proc.new{|line, i| 4 if i >= 3 && line[i-3, 4] == "four"},
        "x" => Proc.new{|line, i| 6 if i >= 2 && line[i-2, 3] == "six"},
        "n" => Proc.new{|line, i| 7 if i >= 4 && line[i-4, 5] == "seven"},
        "t" => Proc.new{|line, i| 8 if i >= 4 && line[i-4, 5] == "eight"}
    }

    # Returns first digit in a string, default is 0
    #
    # @param line[String, #read] the string being searched
    # @return [Integer] the first digit in a given string as an int
    def get_first_digit(line)
        for i in 0..line.size-1
            if @@forward_map.keys.include?(line[i])
                new_digit = @@forward_map[line[i]].call(line, i)
                unless new_digit.nil?
                    return new_digit
                end
            end
        end
        # Document does not specify what to do when no digits are included in the string
        # so I am setting a reasonable default of 0. 
        return 0 
    end

    # Returns last digit in string, default is 0
    #
    # @param line[String, #read] the string being searched
    # @return [Integer] the last digit in a given string
    def get_last_digit(line)
        for i in 1..line.size 
            if @@back_map.keys.include?(line[line.size-i])
                new_digit = @@back_map[line[line.size-i]].call(line, line.size-i)
                unless new_digit.nil?
                    return new_digit
                end
            end
        end
        return 0
    end

    # for each line in input, create a 2-digit integer based on the first and last digit 
    # in the line, then return the sum of each of those integers
    #
    # @param input[String, #read] a multi-line string
    # @return [Integer] sum of each line's calculated calibration 
    def calibrate(input)
        lines = input.split("\n")

        calibrations = []
        lines.each do |line|
            first_digit = get_first_digit(line)
            last_digit = get_last_digit(line)
            calibrations << first_digit*10+last_digit
        end

        sum = calibrations.reduce(:+)
        puts sum
        # I feel like this should be returned even though I don't plan on doing anything with it here
        sum
    end
end

#Commenting out this bit so that VS Code stops suggesting input lines as autocomplete in other areas. 

# trebuchet = Trebuchet.new

# sample_input = """two1nine
# eightwothree
# abcone2threexyz
# xtwone3four
# 4nineeightseven2
# zoneight234
# 7pqrstsixteen"""

# trebuchet.calibrate(sample_input)


# test_input = """9vxfg
# 19qdlpmdrxone7sevennine
# 1dzntwofour9nineffck
# 7bx8hpldgzqjheight
# joneseven2sseven64chvczzn
# seven82683
# 7onefour1eighttwo5three
# 8lmsk871eight7
# ninefivefive2nine5ntvscdfdsmvqgcbxxxt
# onepx6hbgdssfivexs
# cdtjprrbvkftgtwo397seven
# 2eightsix16
# 41pqdmfvptwo
# xhlqvsjpbhfivefour5sevenonemcmrkvhkjqfour5
# 2czddtpsrgsbgddsix6gvmxqlsnnine4
# twozxsix9kmctfour
# 3hqfxkzr2nineqdpgbzndxf2two
# bjd99eight6sfive
# oneeighttwo34dcjck5eightjznpzhxdlc
# 6sixeighttqslqvplsxvpxch
# sixonemc55
# sixeight7five9ninesixfour
# lmbzpzrhssdslkeight9eightpjj
# six2eight579hlbgjnjkqrxrdlhnpfour
# 6fkfxsqncm456onesftkndhl
# bqfckhdmppqvjlkx75dvjzveight8
# btfppljkfkzcklskgzzhmtwo9fjsix
# seven44tgvh
# rvmjm8nlg3ttgcjtwo
# sevendjdckvz9nine6cth
# dpxdpzbmnqsn8prggxn8twotwo4
# twofivesevenonedmkrnpznfhgh1
# gqeightwothreefours16gljkzgnkgclmrpsmfkq
# eighteightsrfcxtvg7three1two9nineeightwolqn
# 18sixlone
# eight7rxfbmhnsf
# 6twodndmhcgxlgbqbqndbbthnngblfgtzh5fouroneightrjp
# 3vpxlzkc
# qpmbxctsmt38sn1
# threefivelxcf9eight
# 5vsptrhgltgqnkcgn4
# threeseven59
# 83eight8sevenklzjcs2
# three5three6twoone9
# fkbfvltznine2bbjpng2zhtmmhnrjq3
# seven1xxjfq6
# 7btxleight4one
# xzsfive3rcxlczkp
# 8bjfmkjc4dxvd9
# sixddfg8onetwotwosbsb
# gmvbngqgfour66eightcspbtjkzlxrqhfrsvfn
# three91djmrkkdkrrsmv
# four4eightlnhtvrscbf5gh5
# seventwo775dcg
# 85sevenfivesixslkjbninefournine
# cljxdshd93rxjppchxonekmvpcmrzrv
# kkzkp315
# three3jxmvjzzvtwojsj1seven
# jvcfzjvfp5gsbpr5fourfour5
# jpfivetxmgthvlqnvjzdgrhknf4dvslqsxtv
# jkvtctx6kkgkeight
# jgsrnzzz8cf4eighteight3
# 88eight1
# one674zclxfive
# 34nlkc8threexfmlqrxbpeight3rj
# 6six9onetgjmvqz63tnrrqlg
# 3n67five16ninevttnvbznlq
# seven98
# 5pkvtpzqs9mvpfpvhb
# 39s1one6phcgfqbgcvhpqv
# sevensevenlhphq5rxffsix
# kvvlqzmglmqddtt87nine
# 5npjkfhmnreightscqf
# 954
# five4tmeightkfdkhdfq34eight
# smdqspmlv3twokthree
# 7fivegvgfhlqsqfxdljnnpninenine429
# sevensixdrsltf6fnhtcssfhpl7
# drctwoneeighttwoninebzvhslngqjhtwo1
# kzeightwo14bjkksx
# 35gglqtcjponenine4lhtjrtjzsf
# six4two9
# 88dpbpbrrnceighteight3
# jf24sqscmzfq
# fourone9three2r2ninethree
# 2fcjl2two8
# ndshrmtqxtwo56eight
# mhlsk7
# hcmx8792six3
# 2sixonexgpzsjbmbqnxbtkbcvmktone
# trqckccvgbdjt7eight9pcnrkxbxrb
# sfqnzdlxqcdf56five27pfb
# cffn1bfjkxdvcthreetvvxfzlrrpmpmddh
# sxone6xzdrsdlfnn19seven8
# twofourtwoqxvpcjmnv3eighteightonetwo
# 9seven453seventhree67oneightv
# 28xmzcttr
# five4twohrlthrjqmthreerzprxcbj
# vlrdjpznp38
# 98nphlf5ztrdzthreeddtnxrkhlzxkttpz
# mqbntpz6eight4
# 28nine
# khkreight3
# 1seven2fivebnjbzd
# cgvdfmncxdn13tp5kxvfqntveight
# 7bkgncbfql68ninetwolfmltr8glvsdpm
# 7onesevennine
# pjtmseven6mhcfrbqnmpbspsrcsixfpfkhjxdhq
# 256one54one
# sonefour4
# vzbsj5nnhpkgkqhthreevlgfvnz6
# qtkrjxgrvs4
# four1fcglninemggpfrone2
# 22trflsckfg7eighteightoneightrbk
# sevenfive5fxmbktqfive43
# twoonedbl1seventwokjjbv
# sixjlkfjnfkzfhvsj5eightmgmh
# gxqjmnjp5pxdksnszcrfivepeight
# eightthree5shxvhnzlhninefourkvchmxfj
# two9mjkxhsevenddtbm696
# 3threedrs3twothree
# d1fivencnbrcvfcbvvphxfour
# sevenfkgjgrt1lzfqzksddlcprlx9six
# one7ckxzglncdgzxcxfour
# three8four6dhn3
# 5rphkp6three2six2
# 7ztzzlnthree4three
# rgxrpczczcsevenrphlhcczm985gdbjcnvjx5
# ggmrcxnrdxfdtd6
# meightwovdrpxgmpjqhpmrdsixhts86cl81
# 4ninejdbzhtfkdnthree26
# 9five8
# six276
# gbsphnmgz5smseven6
# fourgrjvpbkgninetwo1dkrcv
# seven96
# 2sixninexvmxbjttxb
# sixnine3sixsixhvtxone7
# 6x8
# 773fiveeightxtrtshfivemcqxnvplx
# 182mfcthbstt2cvqs
# 13cone1fcgtchxpgs
# three45nblglcktt
# seventzrjngglvpcbdzfivexclqhsjdd5
# jhfmcqdjp8pktwoqgzskmp4
# pbsixtdvshb2three2lq68
# one9nine
# 8six98three8
# 7ninethree1
# gbpchggch74lsmfseveneight
# shshsjlqp7xggv2chskzzdfceightcnhrnine
# twoone1fdzjkdhxeight1
# 8hdxvfblkxfive1seven3mxhv
# hfgmbeight9threefour9
# seven734
# three9three6
# dgnine4eightnineeight
# 66nmltsclptfptxrpj
# 5qcmvt9jhj8five
# 532qbhhz78
# 3bvkm
# 34mpxdthree7nine4k1
# frls93
# sixsevenhtzjqzfthree1ninesixnpv
# jzqgtptsrgx4nine9txzsqghqrbnhflf
# 7f84
# 54sixnsdppg16nine5vcmlcqbmhb
# 4onesixtwoghhpmgltfkxldzjh7
# 5gncbnhztwo6eight7ninez
# 5191jsnqmgeightwojfr
# bvxzrjnhnjjfvvrkvxncs6
# dtwo4
# bgckgdpdzksmlrzfone2two
# x98lqxzxrdrjrkbfk8
# 6gmseven921
# q4eight3eight
# fivenkjkrcvs8hpvnrgpcthreekjfnmtg1vntwo
# 7nine9
# lthqzvxmthreeonefourtwo8fourfour8
# vgn96cmdrnxs
# 94fourdmfpjfbgdc7sb5xldk
# 1eighttwodfzffvpv8eight
# onefivetwo1five
# 6ttjvrlqv2fiveseven5d4
# 87399
# 7hblrjsxdphnplgsevendx
# 6312
# vtwone4five61
# 2fdmhrbdssf
# ztxbmttzvldljxrtt142tkfrfivesevenfive
# zz1one
# fivetwo98
# mcqggtklx39cdz7lkpxthreensztkfmc
# qbzmkprpfd166qhtzpcjhkqpmqrdqtcdgfhtgx
# 95xjrltxrnp
# 4rsjnrone85
# qqnhlgchvvpcrj8dmcjccthreesseven
# fivevbvqdftvxvgxglsevenlvrrknpk9
# 3krqgv5fourq47
# ninetwosixvmt3one
# fcfvzrsbrqcsdhbflhkn9fdgtjxn
# 82onekcxcvjv6dkk
# fkntvmx8
# nineljkckkldnk6
# twoqdptcvnine5tnmstkrsixdc
# ftwone6lmjlntfxptmnnnconepqszsbsbkqkvcxghmhtvsxvfldd
# eightfivexxhjmxvmklhzt52mvh
# 1mmpxmsbpkf368sevennine
# 8six3
# onekh1
# 74nine6gh1bbvsevenone
# 4pxzmslsevengdqqv
# five1qjfxlstfsixnine6pqqseven
# mgbdtwooneeight74hrfflzddfgtnmd
# mrsqnffrhmhjlvqthreesevenseven6fxrfmhfv
# two5threeeightthree
# ddgsixeighttwo26fourgmhg
# nine41g962khzsxzkg
# qfvdz41svzprbzthreedsfcqksix
# threebnbbs5six
# msix1
# three1eightoner4
# b2twojnrfk2zsrzqfourthree
# 3onevqhp
# fjszvhmsix1
# hhjkjxz37nbbsjpfg28btponeightxv
# 2six2krqlzph8
# 5two8jmtkmpfxmkbjqxjbbvnfcgl1
# h2mg
# 3seven2nine6
# five5qbcnsfjxm5nptwotwo
# 6nineoneppcgf5threedcv
# fournjkrjn9zd2cxsfmhjtzfourphflng
# 9seven33five1
# xjmhz86
# 7sevenfivesix
# 3kpdzzninebjzbmnklkhvn
# cvlcqtsix4seveneighthvhrfmsjeight
# 1p
# 2four3xrbhl
# vonerdscjkztwosj8fbxskdzk7
# pnx8nqjninephdhnhmc7
# 1sevenckbxpsix5stlhknddjmgdrpm
# 8vkltvtwo96
# 88xccqf2fg7three
# four75
# jrcfgzddtnlmvjxgttthree1threenmrbone9
# 27btrxjlcqftxkkjvsxnine
# 8qvc98shcjzz
# cjn8three9dphltgdrscdxpv7pzrfg5
# 27sixthree
# 9one7nine3dvvfcztxk
# three82
# bpszb42two9
# twofb5gdzxbt6
# threecrpmqbfivefksjlxgrggb8
# 9eight9five872
# vtrsixjgccvbpdppthreethree1eightjk
# 37lh88four7six
# 6oneseven157fourtbzdtgnkgc6eightwoqdj
# 1two4nineoneone4
# 2fourkqf
# 9xbqpvlfpcfdfqxkqv233
# threeeight3
# xc9three57pnlln
# nineseveng1four
# tfivefive6
# ninedkf6ninerqzdrf
# ploneight675xmgxfrfour
# sevenvsixeight1pxbtmklzp9
# dtldflk1six
# fivetwo8
# eight2kbfmjsvst8
# one2qrtrfblvlnljlmnldmv7dljts
# six39sevenphclhsdts7
# bjrfrzknhctwo138four9sixeight
# hhttbnlrfour3fourfiveqjvzxdgrpxnine
# rvjvqmsscrllhmzmbdlfqlkdfcrjd67one
# xggzxpjmddfive5pvcdhllftb8
# 5315one5
# 2mtjxrxzlftmeightnineqgjpgseventhree
# 464onenine462
# three6sixzstbsq
# 1sevenone
# seven1pkpdeight1qlxfgqpbkzdlj
# 1gj
# 4dzlfbbnfourfive9kp5
# q8m3four9
# 94ldqfrgnd1two
# 38four489eighteightpr
# threekxr261
# tworgmfzsd8jjtvdlxhdpzseventwosix4
# tcsvdphjtgrh2
# nmqxclrszlhgrn3
# 5tzxvkxbpvqgfourmlmnknxt1hjnine
# seven8nbvxqd1
# 3zcqcsj6lfjvsfkfmrsplp3
# ts2ninetrmpjp57pbzfnfb
# 5onesqkk82
# eighteight8
# vkmrvxhjbr3tzjlfksixseven
# hrlxjppxsr83dsgfxmdz6ninemlrnhz
# 8sevenninekvjmfl35nine
# 91
# 35seventkx95six
# eight4two854five
# four4seven2
# fhbnqmlxthreeeight1
# 7threeljeight
# four9cvkztds4pqql
# 5klhghrvgng
# hhz8eighttwothreetwojhbxfmkjeight4
# two9eightwocq
# znj2
# 935eight
# 55eightkdxcmm6fivemrlbsqtvxb
# vzzbjkmjqktwovs5one
# 7vqqrqhcjtzxeightthree
# 34cfninesrcbczg91hptwo
# 63htjrvldqmldzzqrnslzcsfmlcgjmrlnf1zjdrgzkgeightwomrv
# ljdpzttczjthree8five
# flqjdbskkp3kjmcc9nine
# rfcj78five
# ttplggc924vdkbqlcrqs
# ninethreeseven5
# 5sh9
# four6vrrs1
# one7eighteight
# 4szmhdhgdtseven62nine9four
# szsfkfj6cgrprx2
# 38fourkbrlzzfhrseven2foursevenxdv
# 3ninejcghgdchzcffxtl7eight
# 61three
# kbvzkmngj35
# gkzrtccmg3sevenmkdcskvsone
# bg8txkhfiveonerdqvhrcxjrhrlndzjj
# 4v559three
# ninethree4prhnsrmgq
# onenine2lxsixqjsxqlrzkvzcninegz
# 444lxgckhmhxd19ngrhftc
# nine76lznlninesevenfsrknvktmz
# 518onethreeeighttwo
# vxzkrgfshvvtdpsix99vnts
# nine67
# sixtwo2qtncmtxntfthree
# two5five895ccsxdphn4
# 768
# jvsgtwo7sixkhkvfiveqfhjdone
# mqmnrqxbctwo5jtk4tg
# 2174fjrphztmg
# lp4two
# 1qldfxjmzb6
# one8krbtzzdgfjkrmnfnlone737
# 3six4
# nineeight87threefqjgzktgnffrggb
# 8xjhk
# ninesmz44fvx
# gktxcseven2brd28xzkflb
# 42vfqmq8hftsixeighttwoxkfktsgn
# 3fourzkklrbfh2hqvjmgggxrq137
# mthree8eightvjptjvpkhp8tvrzz5twonez
# sc2cbrsrtcnskjsgvd
# 6jxhprlqpxlhkckmxxxplndps8288
# threegjhnbhzfn7977bfjqsqzdtjhxjpkvx
# 9sixthree
# six3sixonedqgtqqzggfive7kgtksd5
# 9djnf9htxlhkphzmthreeqxkrzpljhtx
# 4threefivethreevxvkfour8qv
# eightseveneight1four5fourmvrcxvhx
# tdhtwone4vphnspkn
# onethree81pkbcljs3
# nspprpkgbnnine8gmfqzdlmdone
# vblklpvlfmtcnxgshc1threevth7
# 3ninefivekhcvbeight427
# 5ninesevensevengjbhfbtjgnfhtmldczcgvmfqgrtjhdmxd
# ninebnpvq8two4
# 4lpsrkhmzxmffrq
# four1seven1
# threesix4
# twobcninegnvtcmnxmq9
# 58sixeight1onepdgk3five
# mkkdvjfoursix2nmk
# six21bljfzdl37seven7
# 4eightvtbrr6532
# jf2kxjbfvg
# 6t
# 51mdnkqpnine9
# twojqlrlhnseven2one
# qoneight5
# rmkhbb36four3vtwothree
# vpxfcmmj6fiveonebssninetftgngbxfive4twoneq
# twoseven16
# 6lfivedpvfltcdeighttwonine
# 7krhmggd3578
# vckxnbsgqm4jkjtsqrp1tvvhnfkgsghcrrxqkvb
# jmclhfourkqmp1
# jvtgthree478qxgprsxscfzngxgtgrfjfqqf
# xttnzjcgsxvqrxmhlcnine9two14
# 829
# kmb4ninefgtjgjnxzqjmcxqpprdonesix
# klsnmqtwo4
# 7pjjhtskhdvgtwoxsncbsnj
# mhdhkfive23seven
# zndrdh1xrsxmmxjvp8
# fktwonefcqstdshq8foureightsix
# kzlfqmvbqninetwo4five
# 4sevenjffivezscdqskmfkfzltbh
# 1782
# 6sevenfour
# rleightwoqqnpsbprgtbvssjvd4
# brpfntx5hj
# rqvhgqpdz62eightthree9
# onejgsvzns9
# fournjhjlvvqpfourtwofive6
# 7jxglnsnhbglnjsixxdhbrhgmd
# qznbkl9sevenfourqrnmhfeightjz
# 1threethree5
# four27znfzt4298
# 9fivejvqfdcfqtlxhhm279vl
# 1dgvpsmnsevensix19vchfgbzpmqtdrksxczxt
# twospzvsmjbfqhmcd5zznpgxkfbnbsevenxkzzfhzthree
# 4sixfpxzgblm
# four7sevenbvhxrjf8ffjlbnjkp
# 73twogmnngcjsnine5
# 3fdspqvvrmv
# vq8zqpzfhmmdbgqx55eighteight
# sixeight4jrzhqbjmcgzzxzgzcjcrg969
# zmsfklqskd79
# one85csix4
# 9twodxfqxbhn
# sevensix8xbfmdtzeight4bcdcxdlxmk5four
# 8fdvhpv8tcpqmjsbf6two9dsxrsndr
# jnhsclvtltwo41sixfour2
# mnmmdmsqlxpeight9fjgjgnmvvdxsqlcninesbglbone
# vleightthree7sixsxgd1
# dhsgn2hflhqzrxvfjbn
# 1twofivenine2nine94
# threeqtgdnf8gvxfourjjrbsjgksx
# two8rlxcgsbdftlhx
# 1seventhreethree7
# dvksvxfeightbkccpztwo6
# 35twokpxztqnpl
# ctsnqstklcmcb1xhj
# deightwoxbrkhtgszszqspqeight91zjff
# onehrkvgs34twofourninennddpjtrkp
# 2drv
# 3rjrkmggvfive6nine6fouronethree
# 8twonine35
# gqnn8ldkrjcbd4four
# 8mtgpsflmlkcvkmffnstnqhzrfpscjhxpctvkl
# 89threefive3
# sixxnvtsixxrjqvtkkb1threertdfg
# onenine7ndrthree5
# zfftwoneone59
# hqfzfivezpqkpptthreeseven8sixhb
# six298xgsfvdz
# sxbcgbnrlqsfhjgneightfive6two
# 6zninenine71sevennineone
# txjkscxjxqvhrcmzzbxxxm6ninesix
# cnsr6fivefvvbdjfgrnpqkpsjbgbm
# tkhdhbmqbhfoursix46cbjpvqr7
# trbtfnsps769
# vkrtwonefour78onevktshzxrg9three1
# 5vmxn8vcsxt8
# 3eightfourpxblrzxlfx567
# 626six1seven
# six3fzxsdmlpq
# 44672ztsjrfkhk9six
# 8smbknine
# seven42tt
# five13fivetwotwonegn
# 98fivehpdtwofive
# cvthree491xrhgvlsixp
# four4threezkcfbqcl
# 4six8fivefourfourtwo6
# 8849zcrrf2threetwonevc
# zmzqvnnxskbbt7nine79five
# 8cfkzkzlgdx33
# 6gnineqj1tmmxnhntqgcrjgrcz9
# ninejpjzphsrsevenvtkthgtcq6onesix3
# seventwo1threevrpfqgrdkrnvlftwothreefive
# qgn4nineoneonefqfpvkb
# twofive5569four8
# 9czzvcrglj86mpxctcrrninefour
# 16one5
# 5fiveeight8lqft
# 36oneoneqrvqzzlvnbhnvstjrlsrnlplkccjzjx
# xtjgdvd3eightfb
# vkx2nine1gghfcrdd
# three3dzkxgxjvhgqvfnptmfj
# 8hgvvlgclpl
# three7threefour
# threetxgtrvz4eighttworkd
# rpvlzbxs8
# hgmbvjfxdstpl7tnrgdjzvdtwo7bzhpcghnc
# kkrsprlrgslpszcxmnine44z3eightthree
# jxrljfivegtzbrhxmh6pqmvzf
# twopdvrdffbzjrckcbvp4
# dfms7bcmceightnine7ninethree
# xjpzpqtwo4three1ftpz
# sixeight5two3
# r21
# 1twofivefiveeight47three
# 483onehhfive9
# nbcfngdpqc4
# slnhjm3hcdnntfmbkvzthg
# 4nine5
# zthninevonesixcskc8
# sevenckbqvmjxjx41
# 4c
# nineninegmdpxkttb421jhmlxckm
# onesixthreeone75twoj
# 6sdzj
# 4xddvcvx
# 3sixgsntt2fivethree
# nq1fourm5
# ninesld9fivesix4dxtvnzdmzvxkp
# ptwo8
# 9fkvsxprvpf4five
# 6sbjzd4vdsfvkj9fpcgqksbg
# kgrfsrr17twot
# lshfkltwo88737sevenxskzzpzg
# djxvsnghlm7sevenlh348
# 4onevgcxlzmpncfflhtfrjrhf
# 5sevenjfzkqlpmxknine6
# c3fourvfpzhjcppthree29
# zninellddrfp9
# 3qtcxrppjseventbjvfninetwommbchqbqzx
# eight7sevenn
# qbxqpthreelvxvkprjzsncnz1
# 8gkrxthreeeight8ltwoskdvxkg
# 9seventwodnfghndpxtl
# ltwofive3jzh8two
# seven9qdngkndlbrhd9
# 1m1
# two28fived
# 8one3kbppsdvrn2sevenhkrfive2
# 8one24dkzrxmdxqfourfivev
# dxfive11
# 5glthvkgtzksixfoursix1
# jxxtpndkctfrhrssqtvv6eightchprr
# qdmv9kbtnk5eight83
# sevendkmvljcv6eightwocv
# lpzseven8onesbtskxjrhqhkvfblbjv5
# one5lvcjrkjklsfm8six7
# qjfvdjghsdgzmfivefive5slds7mlcsmlgnpfive
# tsqkjjmfhlrcfjxxsx278ninebnc
# threeknvkkvgpqrzbdn7six
# 512lkhpmdntsxsixzmpcp
# lzvkfkmxlpsix7
# 8fztrnfseven91sixxvbhtzghlcr4
# nine6891lnrfdzntsthree
# rvfmdl92seven
# tlfjnhpsix3onemhmvsthmkftbhcc
# 3kmxcjnsm8six
# onethree479twolht9
# jdlsqp4onefour59lhdthreenine
# qnlpgrsrlhtwoeightfournmsbl2four
# lhptgljveight1vkbfx
# sixsdgv6fourtjltcpkbqrone
# nine1one1
# qxkrfczbpndp5gkghrqbcgcmmqrjjkxxf76dnjbnfc
# 3nineseven99xhmndd94
# 6875twonefns
# 24threeeighttwo
# 3six1threeeightsix2sixp
# xvone27fvmdd11four
# 6eightwolhn
# gseventwobbj9bfrtdzsrjone7qz
# twopbfdzddqninern5gxzbqcj
# 5four4sixfivefb
# 88xtkpjtthreefourtcldldhk
# mnbxx1
# 2dvfour2
# eightfvrsnk27
# fivexfnblfpp77qfour1mrfrphbg
# 6lgddqkjqheight
# rvtwonemdxgfsgnnc98hmonexvmhkzkmjt
# two6cglzbdklmjqjncn5xptwovtbhvmgsd
# sevenkvxn6
# 8eightjkmtncbrv8199six
# sixd14six665
# gbkfpnnjxpmdfivettvdpnbrk16xdnhqkrpljfq
# 58vgmvzx
# onetxxzl9fivelhcfpkvrsgn4
# 25two6mcrvbkxrtltrbsfour
# 517
# rvqq6ninekfmninefiveseven
# five2jp
# qvlcmsqpvmjbjknvlknzfxcqp5
# 1ttsbmjz8bmgrjvtrrthree8dlrjeightrjjvcbcpmv
# 95sixtwonine1
# tkpjkpbq16
# lstsfrltcm1qbzx9
# three713three
# onetwo4eightfivefive
# 7sixxcfive
# 52two9
# xngd1
# 8eightvmktwo4eight
# sixgjjgvtznrskhxnsonetwoqdhtone21
# 9fftwo3
# 5ninevmlvmjnxvb91fourqbnnfcz
# hpcmsgseven2sdp82eightwot
# 3five8
# jnxd6
# 3vfgbml831dkbqsix93
# 6pdlllrll3mskssmddnine8three6
# 4vsdqddkfivethree11pklbpk
# 47five
# 58fivefptcc3xfqvkxqmd
# eight94mrvtn93eight8
# 6fdlbrbbninebmdptsfdzmeightzqmxvpptps
# 1ninegcgcrcgbvtfptlgdthreenflkdhjqjctwoneh
# 8ppqpvrphfhrkgqjrseven
# knklcdrcrcjt545
# ztmqxsevenhpqtgknssnnvdssfpxztwo8threeseven
# xnhoneightf2five
# r3tworkmgkqvtf77qtbxg
# threeone41five57
# fpsix7jrkmmxlhqknjbldthree38
# pzxlnfj2
# sevensevenkbjfvtfzbvgjvzkmnb8eightgggzbz9
# zqkvgk3
# vcpvzhxsxcglhtvmcn2zmqjkxconeonesrdmmmhgjrgkszhxj
# dfjhvgftwo1
# 8fivetwofoursix8fivenine
# rfive5eighttfn1
# fourrnine4bh
# gnh9nine4pbbj
# 4129four22llnx5
# cvdrdzlbmhjchfmvdhhztf4dxnrpvr
# 31fourfivegl2
# hp2eight2klkzlthmd2
# 8mzghdpvjkseven667
# eightfourthreehhxjkljdeight9twoone
# d519
# zlcncbrbnlblfxjtntjkmh4939
# 3484eight9five1one
# 6two365vvllsqcsmrzqnfgrf
# qqtntflfoureightdhzrgg84eight
# 43ndrxmkznbnseventwotfckg9five
# gqxghcjtmnine1
# 622
# nxfdgdgmnd6ninedqnfnvnlkoneeightwob
# nhnfgxrninesix47
# 9nine8jvqrv4two
# ldjklnnfour31oneeight3
# dfhdmtqrttln5five41
# 4seven1six52
# 6nz498sixhbsbjxbzxr
# gpx4four5246
# nqzsqjhqmrninedfxkmnine9431mdgbkn
# ghdfpkxkgtjbsqvmqjsbgljrpbqggpgptwofour8
# 2pmckttc3663rkshqjmvm
# 1seven7gzsevenks8
# tchrd7nq44
# pljkrthree2
# four57
# five138
# k36
# fivednxrs818
# three6eight96eighthvpcrldfiveqkglq
# fivezbnmsevensix3eight
# qbfeightwofour3pcr1sixseventwo
# three4two7
# fivetrdfdqpbt15
# 26nine1
# 3sevenq8eight
# two669six
# 5p4eight219rgkj
# 76four
# jrmnkp1224qrzg6
# 29eightninelvkxbt8
# seven7vq
# lgrgxxk2sbxbcvmjqqs
# 4threesixshtxpgdhnine38
# 6fcmmzhgnmm8
# lxrtjvqzmzeight2ninept
# 2hqd93sixone2nine
# m1
# 4five5threesixnine
# 7sixfxrbr
# eightsix369one
# foursix7seven2bmrqmkb7dbvzrk
# 35seven4onesmsbgbxlh2oneknnlnrg
# hmsevenfour84eighttwo
# eight73sevenseven555jklfjnrts
# ktqbgzvdqdcbreightjkjz4dxnfpfgjs1fvfpbczvt
# xflxseight7smkkkdqsrgoneightx
# 9sixfive3nineonebfqbptl
# rkxtmcltxjeight3fivetwomsjpjdm
# 4bldszkxzrq1threetd
# gnpthree5one
# 3onesevenvbfghbzksrlkl63seven
# 6xjqqsztdsnine1fournine3eight
# 8957four17
# three75
# 5zlsixtwo78
# mjqtlfqztt55eightpsevensevenkrdrvsqxjtphpp
# rztvsc9four5jsrcnvc
# 2fgstpfournine
# onesjjhlcg1nineknqhlr
# ldfone9
# threernszcbdxjdhbmg1eight4
# klkmktxqfz4qcvptvdtwofive8
# 3sbpvfxpsvpsnine7nine
# threexdsbxxrxmmndql19pxzvj
# 1cbn7hvhggznffkp
# 41f
# hdmgqzrhdhseven25zdjdqrrpksixtwo
# 2two7ninesixscd
# two5twojjvkjbs
# eightsix186twonelp
# xpdskdkmjb5hhnkcnxrdbnpj
# 96fourfour
# 7one22
# 1one2qkjszlfourtwoeightgmlfkgsm3
# klqmpxqzhhhk1sixqmmfnmbllqjkvlqdz
# nmgjmhsevensix799
# rrgpsbmnine9ninebqdgnxfsix
# xrmslkfkzfiveninefzzbn7eightndscmjqsldlclkmsxbtjstzds
# bqrjjrbgsixsixjgds1
# 7fmtncmjbgcvhfhlhzzdlltpdscszrlmk88
# fourchvjlhzxxtwo94
# six2one78vkrqvp2sixvhtmqngtk
# fknxmgcljbxfkkbdkbl868nine9
# height12fjt
# knrlb2ninesevenpzjd
# threefourkxtmnxbtfiveeight98fvnkvrx
# 3xxszc
# vhp2rxfrhteightkfive
# cxlzglbnineeightsixxlphhkkkl7eight
# lcltksrvsevensixsixtssrszb55
# 21sjzxsqvlj1seven293j
# 3gkjdshvxkfmxnfkqhpfour56
# kgdbqsmxxqone3p4
# 3m7hmbctwo297
# 4vvr5
# eight11
# nine1six74vzdllp
# 1nine9756sxr6
# 9sevenfourtwovxbshb
# qcgztnjjvvfiveghlbr7
# nfgngg7fntfv
# threeftwonndpzp681
# llbmvrfive5slpjkrpslcthreer
# eightrgmglgds3ggddvtfbrddhpktz
# 75nineonethree6fourseventwonek
# 2226
# 4twokt8
# 2svschdf58eightzpsk1
# gqxthreetmfourcqvzponethree2
# rbsvrl616
# 8threeghjeightshsnheightrvrfhvzgeight
# 6klzknkbkxg76cs38
# vfive4cxrnmkfnmf54cffsnrsbhjtwo
# twozclqgkdfmqfzvjxzbfonetwo5tgrfive9
# hphppvb43ninefive3
# 3tx76threeninefqdtspfxqvq
# 5twoltwo6lvqsfd4
# bvzcthreeqxbjrnnm5
# 61five
# nine1fgsdjvdfrl9ninefour11d
# hfzkbvmbrbh866ninefour
# 4spfmhsdbqn
# fbgqhzpffhfvrnflhttrmx7fourfourrrfrcrnbbcsix
# xczblxnpjjhbxlpffzchjvhhj98jkhvjphb
# two17x
# twodkg2three
# 4ninefour2grfive1eight
# sfsvv5nineninevgshrjonefiveone5
# fiveqqpggmmptjcg5seveneight4threejqpn
# 8sevenfoureightthreegrrjlgn9
# 6fnmtzfqfive72three8
# 7nine7
# 1threelhddbxnndpsgxnb
# 73mpcjnhcn
# 2knbcxnnfvthree
# two4kmbrxzrqgtnineftjlslgdz
# f36992ninefour
# 26fourninesixthree
# zvggfbznineone85nine
# three7threehfour
# 4eightxq7vxdqxjdntc
# 8nineprhgqb9rvkcssflvck2bghnf
# kbkjxjs4eight188rjlmmdgcvr7
# fnkcbmdmbmnglztltrbcnineone6
# 7jjgtlt821
# 78xfgxrtm6four
# 9k5five
# four764one
# 4pmdqzcceight6sevenrl5seven
# ckhvfc92jdrxzxhzgsnkj45
# sgveightwolhl8one454pmcmks7
# hlpbfkqtnjoneeightjnpt9
# tnine8
# ddlhfqglnftnd4
# pdpdvdgdr3twofqzjqqjp8sixtwo
# jq4onetlpzllzmk
# twoseventwotwobpone1twok
# 3759qbxgjfivenine4
# vhxhh31
# cbfkfld3one54
# bpchvxkvtone4npnkccpchvf16sixrpcrftmc
# 3sixeightmhvbxthree
# 2six5qeighttxgfour41
# vjchfvn88kjsdzvkzphlhgsvseven5
# 823nineqd369
# 377
# 8ninethree7
# jvvvz4
# mldjxseven2
# two2xvjrjvqsx8
# ftwo91
# zhndzkhzcqone332
# vcssgkmvneightcdhm1przq
# 8tfvgcheight76
# zqxthsnine7nine
# onezsklndhqllfourfive24qmlvgtm7
# jgh8h1six
# six23
# threehxhvsqpcxrnrpggtwoxtptrlt95
# rhcxxeightthree444djzcckrst
# 9onensgone1eightmfkftpsfctqmn
# 55eight
# 656cpbmgsevenrsqd2onefour
# 3sevenbjlggzzfzxnhkzxtbpgxqbrfgtb4
# 3hhbrdtmmrzssfmtv8
# 28szkfjnzrcv
# 7twopthree
# hnp42
# 5rxg6
# twoeightnfhdbndrtzltninehdtkheight4eightwolpr
# 33sevenmggst
# 2fiveseven
# fhfrmgnsfcthree849bznbtbfourfive
# 1twooneone1four
# fourxlvsgqzzpkzgmsixtwo63
# nmcmgkfdt2fiveeight7
# qnhjdccdqdnine41tjzbpzmztwo7
# 1eightkqftvgmgqnqqgvghvhds4
# 49seven59
# 6trfive9
# sixbtrqxgsdjl6three
# eight4seven
# 14xblhzfdbxeight
# sixlbthqhcmrn7five2eight3
# tpltwonejjvqkz8onelgndpsvxzninenineseven
# sevenfive8twonez
# dkzrpvtkhq664pnine
# nine1m6
# ltwone1fourphtqthreethree1foureighttwo
# threegmlxrnbkmjfvlbmdhn4mcchtmcninetwodtz
# ninerknt1sixsevenfive
# 6vzpjhtwonemc
# sixsevenninexmf6five1
# qrkvjcdvnkh1ssfmqxqmnine83three
# 8cjtsf6hmmnveightsix82
# zphqxnsevenjklnhmfphcfoursixtbmtmkeight5
# 3sevensevendnxdrqskvx
# vpltgsevenpkbspnfzc5qmbdb
# fiveseven5dgkdpjxtzvffqvltwo38
# ninesxljqcmmqf3two
# one19mgdbsmsonethree73lmdchhccc
# 27six
# vd6seven946h
# fourthreerqcnchsfourthreefourgghcmcjvfv4
# mmjhninefiveseven5
# 8eighttls2
# bcconeblccrjckjpr5tqbvpm9
# 1rggt418threevmjhkdztqm5
# 687jzfltlveightone1
# nine5seven4ninexmgnmpqnc
# 6cbthree2
# mdhrs4tqddtrhzxscxxggkgcfiveone
# 5rjfldggflcslhkkjllthree631
# 94pxssc6eighteightfivesix
# fivezmjqnlfggqzsix9
# fivefour369five5
# 4stgkns3xz
# threenine1
# 7qttnmpld89fivetpxgzjhgjpcrhm
# eight158
# 16one
# ninefqbmlkkkhppbvlljbeightc6onefkthmhktkbdjc
# eight533gzndzbl7sevenninefive
# fournine6
# 49pscnggt6one4
# six2seven2fourmeight
# xdvvgsevenjpdjtl7eight6onerj5
# cdmcsjbt7fivevvczqvdpqqcnxttk1two
# fivefourfivespmgsfghdqmpqqvngj6
# 6fkrqlc
# qffdddhmxck23nvnqmczxpvnb8eighttwo
# j6xhzcgskqzk9qtnine3
# three224vdsix
# qhl8lzcvdskb
# six9hxgm
# six3lm8xgptktfbml3
# 3twofive1threeeight6
# 933seven7sspmm
# vvxkvmlpzn7
# 2six6onempljqttngeightgrzkxxsbqb
# fourtjgmd254two
# jptqbmvninenqx69
# cqcsfmzx4kvrcpjm
# jmmmb4mpdxrkvqc5dthree1seven
# psmpdnmb3hthree
# 5612zvndmk
# cdfmfrxrhvsevenbpvpxtsmr9two3
# six7fourt1sixtwo
# 9sevenfour4fdzseven5vdcgvqsix
# dffpldbfourjlklt99
# vhmbrd8qhglxdgninefourdnvcdzfzhssqnmfnlgeightrvff
# sfxkfhx8
# qglscpbxzffivenineone41hbzgjfzzvghtrklp
# rrzvzbqkjl4
# sixfour1zkqtmrkhm26six
# 2rqdcxnine76seven9five
# 8lxnzzt514
# gdhdz572bhbhqhrhxdninebvv
# 3one68eightvjtrqg
# 8775mdcqcjthreehhrshdbtss19
# ddgjkksvhseven22dqsclbgl
# six7vdsix4
# fsbtxfmdzlfxqxpfdxl65sixjpvpkjhqp
# l4r3mgjninedqh
# four2cmk6twoczsnqddjdxgm3three
# gsmhmkfsz8mfninehx
# 5dhgpmdjmdvpvmbone995qdhmmjlg
# tfour35636fiveseven
# vfdv8bzvjqbfpsix
# sixdgfqgxfvr6tdzhzkzknbl
# fivefoursix83eightsevenrcqprm
# eightzxxvckndp58zpq
# 66one
# 8xlgdrjnhxphtsstrptninetwojgvkrprtzklcpjbp
# 8fzdtf
# 8hkljkkck5
# onefivesix6nllxhcczxdszxnxpxbpthree15
# 85oneighttx
# 1fiveqkvflmzsgdxnnthreefour
# 8fczsixone9sixfive
# eight9onedtvszfxsqpvdzmsevenfivejghsqvkhn
# foursevendmrgdbngndeight6fivendmgxkh
# 4446
# 9kbrmsm2eightsfxvldhgsznrlqsixhtfxxllm9
# 8trchslhdfxxhrrkonesix74twoone
# eightnine5cfsrfjpxh141
# four6nine6
# threenmxeightseventhree9threevqzfg
# three9fournineeight25
# four5nhd
# nrkzspjpmfcqxthreerxpxlcknn1rkhggsix
# kzrdjnvxfone5sixsixrdnbvgtwo7
# ninethreefive3vmc63ninebkccndnmq
# seven89eight8fjtfzqlrbmnine9r
# lbhkmjxx46one4
# 32121nine2
# seveneighttskhdjninezzfh4clnhstsnine
# 9fourcvhseven
# pbheightwobpcpfzqfxone6onejmmmtgvhtfour
# 62rkfnbkjkqzthree4twoeight15
# six1jgpvqtwo378
# 4stwosevenxfnqcmglgzxtrbhvd
# nkoneightq35srthgtnjpd
# three6ctx1fiveeight
# eight9eighttnthsddmfz8mktrsix4
# eightpmqqxfqcffour8xflgdscrzmbjhjq1four
# 648one
# threesix88zdsbmsmch5
# fourdpkgxggzvm3
# 262
# 597onethreenine
# 2zsgllcmjz8hvvgbzxpv29qdqnfrj
# 63lxzjglsk59
# 5nineclzblmhqzoneninesixm
# 6eighteightfour9threehnine
# pjrqcmrntwo5g346hhstlmgx
# fhgkhdhqbzrlone9fiveknjmthreethreejqgbgmvxlq
# onesixmhhfckkhcbzffthreegp6
# foursixkbvzvnsdtggpb68onefourctst
# 6zlrrqdnineqfjjq
# 4bx
# dqnsix1onefqlsqlmtlcgpsfrkcx
# 4three2czjxqbf8s4vhsc
# fourtwomdfiverfmsgzfour6one
# qgpctkpdoneonefive2
# vks66
# four5725eight
# tdrxflfkpgtwo35three
# eightfivebxs3
# 8four4298gtfqnmqvqd
# 7jhvtfxs
# 961cvmsbzkonefive2
# rdkfxsix4tnmndhnxnv86
# two4dddpmrhh7fourthreeeight9
# slhdsxngfxszspppxxfftmxlptzhtwovp1
# 4vmzcrhtdvnm6zfive5pkbhcxj"""

# trebuchet.calibrate(test_input)
