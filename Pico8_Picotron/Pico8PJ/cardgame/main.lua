is_select=false
is_game=false --是否进入游戏
menu_cursor={count=1,x=40,y=99,spr=1,blink_c1=0,blink_c2=0}--菜单光标
slt_cursor={count=1,x=9,y=50,spr_up=48,spr_down=49}--选择光标

blinkt=0--闪烁计时器
flipcartcount=0--已翻牌的牌数
--游戏运行状态
gamestate={
    pturnshow_state="pturnshow_state",--玩家回合提示
    eturnshow_state="eturnshow_state",--敌人回合提示
    pstate="pstate",--玩家状态
    enstate="enstate",--敌人状态、
    pcartstate="pcartstate",--玩家牌展示并释放
    encartstate="encartstate",--敌人牌展示并释放
    sendcartstate="sendcartstate",--发牌
    recyclecartstate="recyclecartstate",--回收牌
    endgamestate="endgamestate",--游戏结束
}
--x=5\y=99
playerole=nil
--x=4/y=7
enemyrole=nil

curstate=gamestate.sendcartstate--当前游戏状态：刚进入游戏，先发牌
isenflipcart=false --敌人是否翻牌了
time=0--游戏计时器
showp_turn=false--玩家回合提示
showen_turn=false--敌人回合提示

debug1=""
isfroghurt = false --青蛙是否受伤
iscathurt = false --猫咪是否受伤

function _init()
    music(1)--主界面背景音乐
    poke(0x5f2d,0x1+0x2) --启用鼠标模式
    gamestart()
end
 
function _update()
    blinkt+=1
    _upd()
end

function _draw()
    cls(7)
   
    _drw()
    printdebug()
    --牌阵编号
    --[[
    for i =1,#card_table do
        if card_table[i] then
            print(card_table[i].x,70,i*6-2)
            print(card_table[i].y,85,i*6-2)
        end
    end]]
end

function printdebug()
    --print(time,60,1,8)
end
function gamestart()
    -- 游戏开始
    _upd = update_mainmenu
    _drw = draw_mainmenu
end



