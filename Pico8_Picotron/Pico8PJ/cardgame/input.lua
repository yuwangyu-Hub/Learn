--主菜单输入检测
function mainmenu_input()
    if btn(2) then --上
        menu_cursor.count = max(1, menu_cursor.count - 1)
    elseif btn(3) then --下
        menu_cursor.count = min(2, menu_cursor.count + 1)
    end
    if btn(5) then --确认：键盘X
        if menu_cursor.count==1 then
            --is_game=true
            is_select=true
        elseif menu_cursor.count==2 then --退出：键盘Z
            stop()
        end
    end
end
--选择输入检测
function select_input()
    if btnp(0) then --上
        slt_cursor.count = max(1, slt_cursor.count - 1)
    elseif btnp(1) then --下
        slt_cursor.count = min(4, slt_cursor.count + 1)
    end
    if btnp(5) then --确认：键盘X
        check_select_role()
        is_game=true
    end
end

function check_select_role()
    local t={1,2,3,4}
    if slt_cursor.count==1 then--青蛙
        del(t,1)
        playerole=role[1] 
        enemyole=role[rnd(t)] --随机剩下的
    elseif slt_cursor.count==2 then--猫
        del(t,1)
        playerole=role[2] 
        enemyole=role[rnd(t)] 
    elseif slt_cursor.count==3 then--鸟
        del(t,1)
        playerole=role[3] 
        enemyole=role[rnd(t)] 
    elseif slt_cursor.count==4 then--兔子
        del(t,1)
        playerole=role[4] 
        enemyole=role[rnd(t)] 
    end
    debug1 = playerole
end