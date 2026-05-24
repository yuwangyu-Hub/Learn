-- 更新游戏运行状态
function update_game()
    title_t=0
    mx=stat(32)
    my=stat(33)
    mb=stat(34)--鼠标左键为1、右键为2，中键为4
    
    --游戏回合
    gameturn()
    update_move()

    if isfroghurt then
        hurtshake(frog)
    end
  
    --检测是否牌都被翻了
    flipcartcount=0
    for i=1,#card_table do
        if card_table[i].isflip then
            flipcartcount+=1
            debug2=flipcartcount
        end
    end
    

    --如果一方死亡，有游戏结束

end
-- 更新主菜单
function update_mainmenu()
    title_t+=1
    if title_t>50 then
        
        mainmenu_input()
        if menu_cursor.count==1 then
            menu_cursor.blink_c1=blink()
            menu_cursor.blink_c2=0
            menu_cursor.y=99
        elseif menu_cursor.count==2 then
            menu_cursor.blink_c1=0
            menu_cursor.blink_c2=blink()
            menu_cursor.y=109
        end
    
        if is_select then
            _upd=update_select
            _drw=draw_select 
        end
    end
end

function update_select()
    select_input()
    if is_game then
        
        --选择角色
        music(4)
        _upd=update_game
        _drw=draw_game 
    end
end

--从三个卡组中随机抽牌进入牌阵
function select_cart()
    local r=0 --随机数
    if #card_table < 6 then -- 公共卡：0-5张（共6张）
        --随机6张公共卡  
        repeat
            r=flr(rnd(10))+1
            local is_duplicate=false --是否重复
            for c in all(card_table) do 
                if c.type=="pub" and c.number==pub_cart[r].number then
                    is_duplicate=true
                    break
                end
            end
            if not is_duplicate then
                add(card_table,pub_cart[r])
            end
        until #card_table >= 6
        
    elseif #card_table >= 6 and #card_table < 13 then -- 猫咪卡：6-12张（共7张）
        --随机7张猫咪卡
        repeat
            r=flr(rnd(10))+1
            local is_duplicate=false
            for c in all(card_table) do 
                if c.type=="cat" and c.number==cat_cart[r].number then
                    is_duplicate=true
                    break
                end
            end
            if not is_duplicate then
                add(card_table,cat_cart[r])
            end
        until #card_table >= 13
        
    elseif #card_table >= 13 and #card_table < 20 then -- 青蛙卡：13-19张（共7张）
       --随机7张青蛙卡
       repeat
            r=flr(rnd(10))+1
            local is_duplicate=false
            for c in all(card_table) do 
                if c.type=="frog" and c.number==frog_cart[r].number then
                    is_duplicate=true
                    break
                end
            end
            if not is_duplicate then
                add(card_table,frog_cart[r])
            end
        until #card_table >= 20
    end
end

--将牌阵打乱
-- pico-8 洗牌函数（原地打乱数组表）
function random_cart(t)
    local len = #t
    for i = len, 2, -1 do
        -- pico-8 专用：生成 1~i 之间的随机整数
        local j = flr(rnd(i)) + 1
        -- 交换元素
        t[i], t[j] = t[j], t[i]
    end
end

function gameturn()
    local switchstate={
        pturnshow_state=function()--玩家回合提示
           
            showp_turn=true
            time+=1
            if time>30 then
                curstate=gamestate.pstate
                showp_turn=false
                time=0
            end
        end,
        eturnshow_state=function()--敌人回合提示
            showen_turn=true
            time+=1
            if time>30 then
                curstate=gamestate.enstate
                showen_turn=false
                time=0
            end
        end,
        pstate=function()--玩家选择状态
            isenflipcart=false
            time=0
               --检测鼠标左键点击事件
            if mb==1 then
                --点击牌阵
                if not showcart.isshow then--没有翻开的卡
                    for c in all(card_table) do
                        if mx>=c.x and mx<=c.x+12 and my>=c.y and my<=c.y+14 then
                            sfx(10)--点开
                            --点击牌牌
                            c.isflip=true
                            showcart=c--展示的牌
                            curstate=gamestate.pcartstate
                        end
                    end
               end
            end
        end,
        pcartstate=function()--玩家牌展示并执行
           time+=1
            --执行牌内容
            if time>10 and time<20 then--给10个时间的停顿感
                showcart.isshow=true
                if showcart.type=="cat" then
                    isfroghurt=true
                end
            elseif time>20 then
                --使用右键关闭展示，目前改为自动关闭
                if showcart.isshow then --如果展示卡内容，点击右键关闭展示
                    if mb==2 then
                         sfx(11)--收起
                        --点击展示的牌关闭
                         showcart.isshow=false
                         curstate=gamestate.eturnshow_state
                         time=0
                    end
                end
           end
        end,
        enstate=function()--敌人选择状态
            time+=1
            --敌人翻牌
            ::redo::local r=flr(rnd(20))+1
            --如果敌人没有翻牌，就执行。
            --如果已经翻过就不要再翻，等待时间结束后切换状态
             if not isenflipcart then 
                --随机选择一张牌
                
                if not card_table[r].isflip then
                    card_table[r].isflip=true
                    showcart=card_table[r]
                    isenflipcart=true
                else
                    goto redo
                end
                sfx(10)--点开
             end
            if time>15 then
                curstate=gamestate.encartstate
                time=0
            end
        end,
        encartstate=function()--敌人牌展示并执行状态
            time+=1
            showcart.isshow=true
            if time>10 and time<20 then--给10个时间的停顿感
                if showcart.type=="cat" then
                    isfroghurt=true
                end
            --释放效果后
            elseif time>20 then
                --因为按照顺序敌人回合结束后会全部翻牌，所以这里判断是否所有牌都翻牌了
                if mb==2 then
                    sfx(11)--收起
                    if flipcartcount>=20 then
                        --收牌动画位置信息动画，执行一次
                        card_array_recycle_into_cartble()
                        --切换状态为洗牌
                        curstate = gamestate.recyclecartstate
                        --allcartflip=true
                    else
                        --点击展示的牌关闭
                        curstate=gamestate.pturnshow_state
                    end
                    time=0
                    showcart.isshow=false
                end
               
            end
        end,
        sendcartstate=function()--发牌
            isrecyclefinish=false
                --第一次运行游戏
                if #card_table<20 then
                    select_cart()
                end
                
                --位置信息动画
                --如果没执行过，就执行一次
                
                random_cart(card_table)
            if not isinto_cartble and #card_table==20 then
                card_array_pos_into_cartble()
            end
            --盖牌
            cover_cart()
            if isendfinish then
                curstate=gamestate.pturnshow_state
                isendfinish=false
                isinto_cartble=false
            end
        end,
        recyclecartstate=function()--收牌
             --盖牌
            --cover_cart()
             if isrecyclefinish then
                card_table={}--清空牌阵
                curstate=gamestate.sendcartstate--切换状态为发牌
                isrecyclefinish=false--重置状态
            end
        end,
        endgamestate=function()--游戏结束
            --debug1="endgame"
        end,
    }
    switchstate[curstate]()
end

--盖牌
function cover_cart()
    for c in all(card_table) do
        c.isflip=false
    end
end