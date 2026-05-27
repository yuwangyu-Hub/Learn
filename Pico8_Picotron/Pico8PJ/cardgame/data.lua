--角色数据
role={{
    name="frog",--名字
        sprx=0,--精灵x坐标
        spry=32,--精灵y坐标
        sprw=25,--精灵宽度
        sprh=23,--精灵高度
        max_health=5,--最大血量
        cur_health=5,--当前血量
        attack=3,--攻击力
        defense=3,--防御力
        evasion_rate=0,--闪避率
        state={
            idel="idel",
            defense="defense", 
            hurt="hurt"}
},{
    name="cat",--名字
        sprx=93,--精灵x坐标
        spry=32,--精灵y坐标
        sprw=28,--精灵宽度
        sprh=25,--精灵高度
        max_health=9,--最大血量
        cur_health=9,--当前血量
        attack=6,--攻击力
        defense=0,--防御力
        evasion_rate=0.25,--闪避率
        state={
            idel="idel",
            evasion="evasion", --闪避
            hurt="hurt"}
},{
    name="bird",--名字
        sprx=26,
        spry=32,
        sprw=36,
        sprh=22,
        max_health=3,--最大血量
        cur_health=3,--当前血量
        attack=3,--攻击力
        defense=5,--防御力
        evasion_rate=0,--闪避率
        state={
            idel="idel",
            defense="defense", 
            hurt="hurt"}
},{
    name="rabbit",--名字
        sprx=65,
        spry=32,
        sprw=22,
        sprh=24,
        max_health=5,--最大血量
        cur_health=5,--当前血量
        attack=flr(rnd(3))+1,--攻击力
        defense=6,--防御力:6-attack
        evasion_rate=0,--闪避率
        state={
            idel="idel",
            defense="defense", 
            hurt="hurt"}
}}

--制作一张卡
function makecart(_n,_type,_detail)
    local cart={
        number=_n, --使用编号区分相同的牌
        type=_type, --牌类型
        isflip=false,--是否被翻牌
        x=10,
        y=53,
        detail=_detail,
        isshow=false
    }
    return cart
end

--具体的卡面内容。宽12，长14
frog_cart={
    --单手攻击一次
    makecart(1,"frog","1-hand/atk x1/dmg x1"), --单手攻击
    makecart(2,"frog","1-hand/atk x1/dmg x1"),
    makecart(3,"frog","1-hand/atk x1/dmg x1"),
    --双手攻击一次，伤害翻倍
    makecart(4,"frog","2-hand/atk x1/dmg x2"), --双手攻击
    makecart(5,"frog","2-hand/atk x1/dmg x2"),
    --架盾防御加一
    makecart(6,"frog","shd-grd/def +1/dmg x0"), --架盾shield guard
    makecart(7,"frog","shd-grd/def +1/dmg x0"),
    --青蛙叫攻击力加一
    makecart(8,"frog","frog croak/atk +1/dmg x0"), --青蛙叫
    --吐舌头，降低敌人闪避
    makecart(9,"frog","tongue lash/enemy/eva 0%"), --吐舌头
    --苍蝇团，连续三回合回血
    makecart(10,"frog","swm-fly/hl +1/3 rounds"),--苍蝇团swarm of flies
}

cat_cart={
    --猫爪攻击一次
    makecart(11,"cat","cat claw/atk x1/dmg x1"), --猫爪攻击
    makecart(12,"cat","cat claw/atk x1/dmg x1"), 
    --连续轻挠攻击3-5次，每次1-2伤害
    makecart(13,"cat","rpt-scr/atk x3-5/dmg x1-2"),--轻挠攻击:repeated scratch
    makecart(14,"cat","rpt-scr/atk x3-5/dmg x1-2"),
    --低吼攻击力加一和敌人防御-1
    makecart(15,"cat","growl/atk +1/en def -1"),--低吼
    makecart(16,"cat","growl/atk +1/en def -1"),
    --
    makecart(17,"cat","agile jump/next turn/eva 50%"),--敏捷一跃
    makecart(18,"cat","act cute/next turn/par en "),--装可爱
    makecart(19,"cat","act cute/next turn/par en "),
    makecart(20,"cat","drowsy/self par/en dmg -2"),--犯困
}
bird_cart={
    makecart(21,"bird","down_att/atk x1/dmg x1"),--俯冲攻击
    makecart(22,"bird","down_att/atk x1/dmg x1"),
    makecart(23,"bird","fly/next turn/eva 100%"),
    makecart(24,"bird","fly/next turn/eva 100%"),
    makecart(25,"bird","poop/enemy/eva 0%"),
    makecart(26,"bird","poop/enemy/eva 0%"),
    makecart(27,"bird","wing strike/atk x1/dmg x1"),
    makecart(28,"bird","wing strike/atk x1/dmg x1"),
    makecart(29,"bird","wing strike/atk x1/dmg x1"),
    makecart(30,"bird","wing strike/atk x1/dmg x1"),
}


pub_cart={
    makecart(41,"pub","hl +3"),--加血包
    makecart(42,"pub","hl +3"),
    makecart(43,"pub","hl +3"),
    makecart(44,"pub","atk +1"),--增加攻击力+1
    makecart(45,"pub","atk +1"),
    makecart(46,"pub","atk +1"),
    makecart(47,"pub","def +1"),--增加防御力（猫咪无法使用）
    makecart(48,"pub","def +1"),
    makecart(49,"pub","def +1"),
    makecart(50,"pub","stun/next turn/dis opp x1"),--晕眩：下回合对方无法行动，暂停一回合disable opponent
}


card_table={}--每次牌阵一共20张牌
showcart={}--展示的卡


--封面绘制
fengmian="`ト`トaきnbmfanmyakmenaa░kdjeasnemfagm█admgnca⬇️kjjbaqnfmdadm●acmdnea🐱kmjaapnhmaacm⌂acnga▒kojaaongacm🅾️abnfa█kqjaannfabm➡️acnda█krjaamneabm⧗acnca○ktjaalncabm❎abnbahkbjeaokhadkjalnbabm▥abnaafkijaankfahkiadkgnaabmいabadkljaamkeadfbadksabmえaaacknjaakkeadfdadkraamおaaabkpjaabkmadfdadkrmきaak█affbafkqmきaak█ankqmきaakhackuankqmきkhaektankqmきkgacfbabktalkrmきkfadfbacksalkrmpgemxgemnkfaiktajksmngaadgdmtgaadgdmlkfaikuahktmlgbafgempgbafgemjkgagkxadkvmkgbahgemngbahgemikhaek⧗mkgaajgdmngaajgdmikiack⬆️mjgbajgemlgbajgemhkきmjgbajgemlgbajgemhkきmigcajgfmjgcajgfmgkきmigdahggmjgdahggmgkきmigeafghmjgeafghmgkきmigfadgimjgfadgimgkきmigsmjgsmgkきmjgqmlgqmhkきmjgqmlgqmhkかaamkgomngomik☉jbktabmkgomngomik♥jdksabmlgmmpgmmjk♥jdkracmngimtgimlk☉jbkradmpgemxgemnk|jbk~admきk{jdk|aemきk{jdk{aekamきk|jbk{aekbm{almyk▤aekcmzanmxk❎aekdmzanmpacmek∧aekemeaemqalmmadmhk⬆️afkfmjaemnahmlacmlk⧗afkgmoafmjadmjadmok➡️agkhmuacmgadmhabmsk◆ahkim█abm~k♪ahkkm█abm~k⌂ajklm█abmqakmbk☉ajknmmakmhabmkafmmk●ajkpmbakmsabm~k⬇️akkrm○adm}k○alkumpabmeabmdacmbacmeabmdabmnk|amkwmpacmaacmeacmdacmfafmnkxapkxmqadmeadmfadmeaemnktarkzmnacmaakmhakmbacmkkpask}mkacmeaimjaimfadmgkhaxk█mhacmjaemnaemlacmdkgauk░meacm▤kgapk웃mきkhaik◆mきkきmきkきmきabgbnhgca✽gcnif⬇️a}aagcnhgda⬇️gcnigaf✽a{aagcnigca🐱gcnjgaf♥ayaagcnjgca█gcnkgaf☉amgcahaagcnjgca█gbnkgbf⌂ajgafcahaagcnjgca█gbnkgbf⬅️ahgafdahaagcnkgba○gbnlgbf😐afgafdaiabgbnkgca~ganmgbf🅾️acfeajabgbnkgca}gbnlgcf◆aafeakabgbnlgba}ganmgcf⬆️adgcaeabgcnkgba}ganlgcaaf⧗aafagcfcgbacabgcnkgba|gbnlgbabfうgaacabgcnlgaa|gbnkgcabfうadacgbnlgaa|gbnkgcabf❎aiacgbnlgaalgoagnfgcacf⬆️alacgcnkgaafg|adnagcadf}gefraladgbnkgaacg⬇️ahf{gifqakadgcnjabg♥affzgkfpakadgcnhabg♪abfggdfngmfpajaegcneabg➡️feghfkgjacgbfpaiaegdnbabg⧗fdgjfjgiaegafpaiafgdaagˇfdgfacgafigiaggafpahaggbaag∧fcgfaegafhgiaggafpahaig❎fcgfaegafhgiaggafqagahg▤fcgfaegafhgjaegbfqagagg▥fcggacgbfhgkacgcfrafafgあfdgjfjgoftaeaegいfdgjfjgoftaeadgうfeghflgmfvadacgえfggdfogkfwadacgえfqicfggifyacabgoaag○adgkfoiffhgef{acaagnadg}afgjfnihf♥acaagmafg{ahgifmijf●acgmagg{ahgiflikf♥abgmahgyahgjfkinf✽abgmahgyahgjfkiof░abgmahgyahgjfjiuf○abgmahgyaggkfiiwf○aagnaggyaggkfhixf○aagnaggyafglfgizf~aagoaegjahgiadgmfgiyf○aagpacgjajgiabgnffizf○aag}ajgyfeizf█aag}aigzfeiyf▒aag}aggsnegdfdiwf✽ghnegradgsnggcfdiuf♥ggnggsabgrnigbfdirf⌂gfnigraagaaagpnkgafdipf😐genkgqaagaaagpnkgafeimf🅾️genkgpaagbaagpnkgafeikf…genkgpaagcaaggaaggnkgaffiif➡️genkghabgeaagdaagfaaghnkgaffihf★genkgiaagdaagfafgjnigbfgigf★gfnigkadgxnggcfhiff★ggngg웃negdfiief★ghneg⧗fkidf➡️gきfきgきfきgきfきgきfきgきfきaagかfきabgおfき"
--标题
title="`や`🐱`かhb`cha`hha`p`おhc`bhc`fhc`ihb`d`🐱hb`khb`lhagafaha`ahagahb`fhd`ghd`c`hhd`ghd`jhd`ihd`khagafahbgafaha`ghagbha`fhbgahb`c`ghbkbhb`ehbkbhb`ihambhb`ghbmbha`khafbhagafaha`hhaganaha`fhanagaha`d`fhbkaabkahb`chbkaabkahb`hhamanamahb`ehbmanamaha`khafahafbha`ihaganaha`fhanagaha`d`fhakbabkbhekbabkbha`hhamanbmahgmanbmaha`ihcfdhb`ihanaha`ehanbha`e`ehu`fhbmanbhinbmahb`ghcffhc`ghanbha`dhanbha`e`bhむ`b`ahも`ahゆhはgahjhfgch⬇️gah✽gbhjhfgch🐱gbh✽gbhjhegeh▒gbhhgehwgbhkhegbhagbhlgbhsgbhggghvgbhkhdgbhbgbhlgbhsgbhfgdhbgchtgchkhdgbhbgbhfgbhygbhegdhdgbhtgchdgchdhdgbhcgbhdgdhjgehbgdhcgbhegch{gbhdgehchdgbhcgbhdgehbgbhbghhagehcgbhdgchpgbhcgbhcgdhcgbhbgbhchdgghcgchagbhbgbhbghhagbhbgahcgbhdgchkgchbgbhbgbhcgehcgbhghcgfhagbhbgbhbgbhbgbhbgbhbgahbgahagbhbgbhbgbhcgchkgehagehcgbhbgbhcgchfhcgdhcgbhbgbhbgbhbgbhbgbhbgahbgahagbhbgbhbgbhcgchjgbhbgbhbgchcgbhcgbhdgchehcgbhegbhbgbhbgbhbgbhbgbhbgahdgghagchbgchjgbhbgbhbgchcgbhbgchegdhchcgbhegbhbgbhbgbhbgbhbgbhhgchagbhbgbhbgchjgfhcgbhcgghggchbhbgchegbhbgbhbgah}gdhegbhcgfhbgbhdgghggbhbhbgbhfgbhbgbh▒gdhcgchfgchigahcgbhcgbhagchbhbgbhjgah⬇️ghh|gehchbgbh…geh~gchdhbgbhむhゆhゆhゆ`ahも`a`bhむ`b"

--卡面的绘制数据
--猫:猫爪攻击一次
cimage_1="`w`wfxfxfxfxfmbcfhfhbbfbbamcbafgfgbambbafabamdfgffbamdbambgbmabaffffbamabbmcbagcbafffdbbmbgbbamcbagabdfdfcbamdgbbamcbagabamagbbafcfcbamdbagbmcbbmcgbbafbfcbamabagambbagabamancmcbagabafbfdbbgbmcnembbafabbfbfcbambbagabamanembbafffcbamcbbmancmdbafffcbamabamdnbmcbbfgfcbbgabamabamdbbfifdbagbbafabdfkfebagabafpffbbfpfxfxfx"
--连续轻挠攻击3-5次，每次1-2伤害
cimage_2="`w`wfmbbfiflbambbafhfibafbgamagabafhfhbbfcbambbafgfhbamabafcbamabafgffmdbafdbamabafffemfbafcbamabafffcbbmbgamdbbfabamabafffdbagamaaagamcbamabbmabafffdgaaamfbamabamcbafefdmbaamdbamfbafefemdbamhbafeffmabbmibbfdfhbamhbamabbfcfhmlbbfbfhmmbbfafimmbafafimnfafimnfafimibcmbfafjmbbamdbamcbamafafjmcbambbamffafjmcbbmabamffafx"
--低吼攻击力加一和敌人防御-1
cimage_3="`w`wfxfxfxfcbafobbfcfbbamabbfkbbmabafcfbbamcbbfabefbbamcbafcfbbamebamebbmdbafcfbbampbafdfcbamobafdfcbampbafcfbbamdbdmfbefbfabamfbagaaabbmbbbaagabamabafbbbmfbagaaagabambbagaaagabambbafabamhbcmaacbcmcbafabamaadmhaameacbabameacmiabmcbabamkaagaaagamfbafafabamdacmbaembabmabafbfbbaacmeaahbabmdacfafcbbmfaahagahagamcbafdfcbamabbmjbcfdfbbamhbdmebafcfabamrbafcfamsbafc"
--敏捷一跃
cimage_4="`w`wfpbcfefobamcbafdfobamdbafcfpbbmcbafbfrbambbafbfrbambbafbfdbbffbbfcbamcbafbfdbamabafdbamabafabbmcbafcfdbambbdmbbbmdbafdfdbamhbamfbafcfdbagbmcgbmabamfbafcfdbagaaamcaagamabamgbafbfdbamcaamdbamhfbfebambhamcbamifbffbamcbbmebambbamafbfebamkfabbmcfafdbambbamdbamcfdmcfafcbambbcmbbamcffmbfafbbambbafbbambbamafkfbbcfbbambbafmffbambbafnfebambbafofebcfpfx"
--装可爱
cimage_5="`w`wfxfcbbflbbfefbbambbafjbamabafefbbamabamabafhbamabbfefbbamabbmabafabdfabamabamabafefbbamabcmabamdbamabbmabafefbbambbamjbamabafefcbamnbafefcbamcabmeabmcbafdfbbamcabgaaamcaagaabmbbafdfabamdaabaabmcabbaaambbafdfabameaabamebaaamcbafdfabaminamebcfdfbbamfbamabamabambbambbafdfcbamfbamabambbanamanamabafcfdbamabcmfbamcnabafcfebamcbamfbanbmabafcfdbamcnabamfbambbafdfdbamanbbamgbambbafdfcbbmcbamfbamdbafcfbbamabamcbamkbafcfbbamabamdbamjbafcfabambbamdbamjbafcfabamgbamkfc"
--犯困
cimage_6="`w`wfxfibgfhfgbbmgbbfffebbmkbafefdbamcbamjbafdfcbamcbcmjbafcfbbamdbanabbmjbafbfbbamcbamanbbbmjbafafabamcbamfbamibafafabambbamhbamibabdmgaamabamabbmfbafabanbmfaambbbmhbafabbnamibamibafbbbmcaamanambbamjbafbbbmbaamdbbmjbafbbamabamebamabamibafafbbambbemcbamdbamcbafafcbambbamanabdmdbamcbafbfdbambbbnamebbmdbafbfebamcbfmebafcffbbmjbbfdfhbjfffxfx"

--青蛙：单手剑攻击
fimage_1="`w`wfkacfjfkaambaafiflaambaafhfmaambaafgfnaambaafffhacfaadmbaaiafdfgaakbjaaakbjaabmaiamaaafcffaakaiaaakdaaiaaaiamaaakaaafbffaakaiagaaakbaagaiaackbiafbfaabfbabkaickfaakbaaibfaaacbabcaabkhaakbaafaiafbaccbakkbaafefaajcakdabfffaaokaaafffbahkbjbaafaaakaaafefcafkcjbabfaaakaaafdfeadkcjbkbacfefgaakjaafeffaakcafkbaafeffaakbaafcaakcaafffeaakbaafcaakcaakaaafefdaakbaafeaakeaafdfcaakcaaffackaaafefckaaakaaakaaafhaaff"
--双手剑攻击
fimage_2="`w`wfkaaflfjacfkfiaafaaamaaafjfiaafaaamaaafjfiaafaaamaaafjfgacfaaamaacfhffaakcfaaamakcaafgffaakcfaaamakcaafgfeaakaiaaakamaaamakaaakbaafffeaakaiagaaafaaamaaagaiakaaafffeaakbibmaaamaibkbaafffdackcmaaamakcacfefdabcaaakaiekaaacaabfefdaacakbaacakbcakaaafakacaaafefdaacakacbkccakacakbcaaafefeaacakbcckacakbcaaafffdabcakacakacakecaabfefcaacaabcakbcfabcaaafdfbaacaadkbjckbadcaaafcfbaacaackcjckcaccaaafcfbadkkadfcfbaafbaakcaekcaafbaafcfeaakbaafeaakbaafffdaakaaakaaafeaakaaakaaafe"
--架盾
fimage_3="`w`wfxfxfxfgacfbacfiffaakcabkcaafhfeaakaiaaakeaaiaaafgfeaakaiagaaakcaagaiaaafgfdaakbibkeibkaaafffdaaklaafffdaakdaekcabfefdackhabmbabfcfcabcbabkeaamfaafbfcadcbaembfaibfambaafafcaakcaaceaamafbibfbmaaafafcaakaaimaibfbibmaaafafbabkaadkajcaamaibfbibmaaafafbabkbabkbjcaambfaibfambaafafbabkbabkbjckaaambibmbaafbfaafkhaamdaafcfcadkcackcaambaafdfeaakbabfcabkbabfefeaakbaafeaakbaaffffaakbaafcaakbaafgfeaakaaakaaafcaakaaakaaaff"
--蛙叫
fimage_4="`w`wfxfkjffgfkjafajafajafhfhjdfajafajafhfhjafajbfajafajafhfhjbfajafajafbjafgfkjafajbfajafgffadffabfffeaakdaafdaakbaafefdaakbibkbadkbgaiaaafdfdaakaiaaagaiakgaaiaaafdfdaakaiaabiakhabfdfdaakbibkdaekaaafdfcaakgabbeaakaaafcfbaakgaabgaakaaafcfaaakgaabgaakaaafdaakgaabhaakaaafdaakfaabahcbbhabbaakaaafdaakejaaahebahbbbaakaaafcaakejbaahebahbbaaajaaafcaakdjdaahgbaaajaaafcaakdjeaaheabjbaafcaakcjgaejcaafdaakcjoaafd"
--青蛙吐舌
fimage_5="`w`wfxfxfxfxfxfxfhabfeadfefgaakbaafcaakdaafdhafeaaiagakbackbibkbaafcfahafdabkgiaabiakaaafcfbhafcaakbaekbibkbaafchafdaakbaabeaakffchcfbaakaaabgaakeaafbfbhbfaaakaaabdaekeaafaffaakaaabbagjakdaaacfbaakaaabbnahabdabjakencadnbhebcaajakehcndhhbaaajckdhjbeaajdkdhgabbchbaajfkcheacjaaejfkdhcabfbaajlkdacfchafaacjhkefdhbfbaajikf"
--苍蝇团
fimage_6="`w`wfxfnmafifomafbmbfdfcmbfambfgabmafffdmaaamafghaaahaabfefdaahaaahafiacfdfcabfsfnmafifkmafamafjfkhaaahafjfmabfifxfxfxffadfdadfffeaagaabgaaafbaakaabgaaafefeaagaabiakaabkaiaabgaaafefeaagbibkeiagbaafefeackcaakbaakbabfefdaaknaafdfdaakoaafcfcaakfaekeaafcfcaakdabkeabkcaafcfcaakbabkiabkaaafc"
