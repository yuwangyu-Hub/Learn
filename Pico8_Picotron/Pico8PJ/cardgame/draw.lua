-- 绘制游戏内容
function draw_game()
    --左侧角色绘制
    draw_ui_frog()
    draw_ui_cat()
    --牌堆造型
    --牌堆位置：10，53
    sspr(0,8,13,9,10,67)--厚度
    draw_card_back(10,53)
   
    --背面摆阵
    for c in all(card_table) do
        --检测是否被翻牌
        if c.isflip then
            draw_card_front(c.x,c.y)
            --绘制信息
            print(c.number,c.x+2,c.y+2)
        else
            if c !=moving_card then
                draw_card_back(c.x,c.y)
            end
        end
    end

    --移动牌绘制
    if moving_card then --如果有移动牌在移动
        if moving_card.isflip then
            draw_card_front(moving_card.x,moving_card.y)
            print(moving_card.number,moving_card.x+2,moving_card.y+2)
        else
            draw_card_back(moving_card.x,moving_card.y)
        end 
    end


    --选中牌后，显示牌信息
    if showcart.isshow then
        --底框
        rrectfill(50,27,52,77,3,7)
        
        if showcart.type=="cat" then
            rrectfill(51,28,50,10,3,13)
            line(51,37,100,37,13)
            cprint("cat",76,31)
        elseif showcart.type=="frog" then
            rrectfill(51,28,50,10,3,11)
             line(51,37,100,37,11)
            cprint("frog",76,31)
        else--public
            cprint("public",76,31)
        end
        rrect(51,28,50,75,3,1)
        print("nO."..showcart.number,54,40)
        --牌详情
        card_detail_show(showcart.detail,54,80,1)
    end

    --鼠标绘制
    if curstate==gamestate.pstate or curstate==gamestate.pcartstate or curstate==gamestate.encartstate then
        spr(7,mx,my)
    end

    --提示回合
    if showp_turn then
        show_turn("player turn",0,50)
    elseif showen_turn then
        show_turn("enemy turn",0,50)
    end
end

function draw_select()
    --选择框
    local select_x=slt_cursor.x
    local select_y=slt_cursor.y
    for i=1,4 do
        sspr((i-1)*24,64,20,20,select_x+(i-1)*30,select_y)
    end
    --选择光标
    spr(slt_cursor.spr_up,select_x+6+(slt_cursor.count-1)*30,select_y-6)--上方
    spr(slt_cursor.spr_down,select_x+6+(slt_cursor.count-1)*30,select_y+22)--下方
end

local title_y=-35
local title_t=0 --标题时间
function draw_mainmenu()
    
    if title_y<40 then
        title_y+=2
    else
        title_y=40
    end
    
    --绘制封面
    rle1(fengmian,0,0,0)

    --游戏title
    rle1(title,17,title_y,0)

    if title_t>50 then
        -- 绘制主菜单
        cprint("game start",70,100,menu_cursor.blink_c1)
        cprint("game ex-it",70,110,menu_cursor.blink_c2)
        palt(3,true)
        palt(0,false)
        spr(menu_cursor.spr,menu_cursor.x,menu_cursor.y)
        palt()
    end
end

function draw_ui_frog()
    --青蛙精灵
    sspr(frog.sprx,frog.spry,frog.sprw,frog.sprh,frog.x,frog.y)
    --血量
    for i=1,frog.max_health do
        draw_spr(i*6-4,120,2,false)
    end
    for i=1,frog.cur_health do
        draw_spr(i*6-4,120,2,false)
    end

    --双手道具库
    rectfill(3,81,16,94,12)
    rect(3,81,16,94,1)
    rectfill(19,81,32,94,12)
    rect(19,81,32,94,1)
    --剑
    sspr(24,0,6,10,7,83)
    draw_print(frog.attack,14,91,10)
       --盾
    sspr(31,0,9,9,21,83)
    draw_print(frog.defense,30,91,10)
end

function draw_ui_cat()
    --猫咪精灵
    sspr(cat.sprx,cat.spry,cat.sprw,cat.sprh,cat.x,cat.y)
    --血量
    for i=1,cat.max_health do
        if i<=5 then
            draw_spr(i*6-4,1,2,false)
        elseif i >5 then
            draw_spr((i-5)*6-1,6,2,true)
        end
    end

    --血量
    for i=1,cat.cur_health do
        if i<=5 then
            draw_spr(i*6-4,1,2,false)
        elseif i >5 then
            draw_spr((i-5)*6-1,6,2,true)
        end
    end

    --双手道具
    rectfill(3,34,16,47,12)
    rect(3,34,16,47,1)
    rectfill(19,34,32,47,12)
    rect(19,34,32,47,1)
     --左猫抓
    sspr(45,8,10,8,5,37)
    draw_print(cat.attack/2,14,44,10)
    --右猫抓
    sspr(45,8,10,8,21,37)
    draw_print(cat.attack/2,30,44,10)
end

--提示回合
function show_turn(txt,x,y)
    local spry=0
    if txt=="player turn" then
        spry=9
    elseif txt=="enemy turn" then
        spry=0
    end
    rectfill(0,y-6,128,y+16,6)
    cprint(txt,64,y+8,1)
    for i=1,4 do
        sspr(64+(i-1)*9,spry,9,9,44+(i-1)*10,y-2)
    end
end

