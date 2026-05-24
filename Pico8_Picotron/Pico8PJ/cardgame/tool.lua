--中心打印
function cprint(txt,x,y,c)
	print(txt,x-#txt*2,y,c)
end

--闪烁显示
function blink()
	local blink_anim={5,5,5,5,5,5,5,5,6,6,7,7,6,6,5,5}
	return blink_anim[blinkt%#blink_anim]
end

shake_t=0
--受伤震动*
function hurtshake(ani)--animal
    shake_t+=.1
    ani.x += sin(shake_t*3)
    ani.y += sin(shake_t*3)
    
    if shake_t>1 then
        shake_t=0
        if ani==frog then
            ani.x=5
            ani.y=99
        end
        if ani==cat then
            ani.x=7
            ani.y=7
        end
        isfroghurt = false
    end
    --初始位置
end

--描边绘制spr版本
function draw_spr(_x,_y,_spr,_cl)--_c为描边颜色
    local cl=_cl or 1
    --为了覆盖色板
    local black_table={cl,cl,cl,cl,cl,cl,cl,cl,cl,cl,cl,cl,cl,cl,cl,cl}
    --上下左右四个方向，偏移一个像素
    local side_table={{-1,0},{1,0},{0,-1},{0,1}}
    pal(black_table)--所有颜色设置为黑色
    --四次循环，绘制四个方向
    for _,d in ipairs(side_table) do
        spr(_spr,_x+d[1],_y+d[2])
    end
    pal()--恢复色板
    spr(_spr,_x,_y)
end

--描边绘制sspr版本
function draw_sspr(_x,_y,_w,_h,_px,_py,_cl)--_cl为描边颜色
    local cl=_cl or 1
    --为了覆盖色板
    local black_table={cl,cl,cl,cl,cl,cl,cl,cl,cl,cl,cl,cl,cl,cl,cl,cl}
    --上下左右四个方向，偏移一个像素
    local side_table={{-1,0},{1,0},{0,-1},{0,1}}
    pal(black_table)--所有颜色设置为黑色
    --四次循环，绘制四个方向
    for _,d in ipairs(side_table) do
        sspr(_x,_y,_w,_h,_px+d[1],_py+d[2])
    end
    pal()--恢复色板
    sspr(_x,_y,_w,_h,_px,_py)
end

--带描边的打印
function draw_print(_txt,_x,_y,_cl,_c)
    local cl=_cl or 1
    local c=_c or 1
    --为了覆盖色板
    local black_table={cl,cl,cl,cl,cl,cl,cl,cl,cl,cl,cl,cl,cl,cl,cl,cl}
    --上下左右四个方向，偏移一个像素
    local side_table={{-1,0},{1,0},{0,-1},{0,1}}
    pal(black_table)--所有颜色设置为黑色
    --四次循环，绘制四个方向
    for _,d in ipairs(side_table) do
        print(_txt,_x+d[1],_y+d[2],_c)
    end
    pal()--恢复色板
    print(_txt,_x,_y,_c)
end

--卡背面绘制
function draw_card_back(_x,_y)
    rectfill(_x,_y,_x+12,_y+14,2)
    rect(_x,_y,_x+12,_y+14,1)
    spr(6,_x+3,_y+2)
    spr(6,_x+3,_y+5,1,1,false,true)
end

--卡正面绘制
function draw_card_front(_x,_y)
    rectfill(_x,_y,_x+12,_y+14,6)
    rect(_x,_y,_x+12,_y+14,1)
end

card_queue={}--发牌队列
moving_card=nil--正在移动的卡
move_func=nil  --移动函数
isendfinish =false--是否发牌完成
isrecyclefinish=false--是否回收牌完成
isinto_cartble=false--是否进入牌阵
--卡牌摆阵输入位置信息
function card_array_pos_into_cartble()
    card_queue={}--清空队列
    isinto_cartble=true--进入牌阵
    
    local x=40--牌阵的x坐标
    local y=30--牌阵的y坐标
    local cart_index=1
    --背面摆阵
    for i=1,4 do
        for j=1,5 do
            --如果牌索引超出范围，跳出循环
            if cart_index >20 then goto endloop end 
            local card = card_table[cart_index]
            if card then
                --目标位置
                local fx=x+(j-1)*15
                local fy=y+(i-1)*17
                --将牌加入队列，等待移动
                add(card_queue,{card=card,fx=fx,fy=fy})
            end
            cart_index+=1
        end
        
    end
    ::endloop::
end
--卡牌回收摆阵输入位置信息
function card_array_recycle_into_cartble()
    card_queue={}--清空队列
     local cart_index=1
    --背面摆阵
    for i=1,4 do
        for j=1,5 do
            --如果牌索引超出范围，跳出循环
            if cart_index >20 then goto endloop end 
            local card = card_table[cart_index]
            if card then
                --目标位置
                local fx=10
                local fy=53
                --将牌加入队列，等待移动
                add(card_queue,{card=card,fx=fx,fy=fy})
            end
            cart_index+=1
        end
    end
    ::endloop::
end
--移动工厂--闭包
function create_move(card,targtx,targty)
    local speed=5
    --返回每帧要执行的移动逻辑
    sfx(9)
    return function()
        local dx = targtx-card.x--目标位置的x轴距离，card默认位置已经设置为10
        local dy = targty-card.y--目标位置的y轴距离，card默认位置已经设置为53
        
        local d = sqrt(dx*dx+dy*dy)--直线距离
        if d<2.5 then
            --牌移动到最终位置
            card.x=targtx
            card.y=targty
            return true
        end
        --移动牌
        --归一化方向
        card.x+=dx/d*speed
        card.y+=dy/d*speed
        return false
    end
end

function update_move()--更新移动
    -- 当前没牌在移动 且 队列还有牌
    if moving_card == nil and #card_queue > 0 then
        -- 取出第一张
        local item = deli(card_queue,1)--deli：删除数组中的元素，返回删除的元素值
        -- 创建这张牌的移动器
        moving_card=item.card
        move_func = create_move(item.card, item.fx, item.fy)
       
    end
    
    -- 正在移动就执行
    if move_func != nil then
        local done = move_func()
        if done then
            -- 移动结束，清空，自动发下一张
            move_func = nil
            moving_card = nil
            -- 检查是否所有牌都移动到目标位置
            if curstate==gamestate.sendcartstate then --发牌模式
                isendfinish=check_card_move(card_table,"send")
            elseif curstate==gamestate.recyclecartstate then --回收牌
                isrecyclefinish=check_card_move(card_table,"recycle")
            end
            
        end
    end
end
--检查是否所有牌都移动到目标位置
function check_card_move(card,type)
    local i=0
    --检查是否所有牌移动到目标位置
    if type=="send" then --发牌模式
        for e in all(card) do
            if e.x != 10 and e.y != 53 then
                i+=1
            end
        end
    elseif type=="recycle" then --回收模式
        for e in all(card) do
            if e.x == 10 and e.y == 53 then
                i+=1
            end
        end
    end
    debug1=i
    --如果所有牌都移动到目标位置
    if i == #card then
        return true-- 发牌完成
    else
        return false-- 发牌未完成
    end
end

function check_card(c)
    if c.type=="frog" then --青蛙
        if c.number==1 or c.number==2 or c.number==3 then
            --单手攻击
            iscathurt=true
            cat.cur_health-=frog.attack
        elseif c.number==4 or c.number==5 then
            --双手攻击
            iscathurt=true
            cat.cur_health-=frog.attack*2
        elseif c.number==6 or c.number==7 then
            --架盾
        elseif c.number==8 then
            --青蛙叫
        elseif c.number==9 then
            --吐舌头
        elseif c.number==10 then
            --苍蝇团
        end
    elseif c.type=="cat" then --cat
        if c.number==11 or c.number==12 then
            --猫爪攻击
        elseif c.number==13 or c.number==14 then
            --轻挠攻击
        elseif c.number==15 or c.number==16 then
            --低吼
        elseif c.number==17 then
            --敏捷一跃
        elseif c.number==18 or c.number==19 then
            --装可爱
        elseif c.number==20 then
            --犯困
        end
    else --pub
        if c.number==21 or c.number==22 or c.number==23 then
            --加血
        elseif c.number==24 or c.number==25 or c.number==26 then
            --增加攻击力
        elseif c.number==27 or c.number==28 or c.number==29 then
            --增加防御力
        elseif c.number==30 then
            --晕眩
        end
    end
end

-- 逐字打印文本，遇到 / 自动换行
-- txt: 要打印的字符串
-- x,y: 起始坐标（默认 1,1）
-- color: 文字颜色（默认 7 白色）
function card_detail_show(txt, x, y, color)
    -- 默认值
    x = x
    y = y
    color = color
    -- 当前绘制坐标
    local cx = x
    local cy = y
    -- 遍历每个字符
    for i = 1, #txt do
        local c = sub(txt, i, i)
        
        -- 遇到 / 就换行，不打印这个符号
        if c == "/" then
            cy = cy + 6  -- PICO-8 标准行高
            cx = x       -- 回到起始X
        else
            -- 正常打印字符
            print(c, cx, cy, color)
            cx = cx + 4  -- 标准字符宽度
        end
    end
end



--封面绘制函数
function rle1(s,x0,y,tr)
    local x,mw=x0,x0+ord(s,2)-96
    for i=5,#s,2do
        local col,len=ord(s,i)-96,ord(s,i+1)-96
        if(col!=tr) line(x,y,x+len-1,y,col)
        x+=len if(x>mw) x=x0 y+=1
    end
end
