#!/bin/bash
#图书管理系统
#作者: Lyons 
#日期： 2015/10/25
# superhookm@gmail.com
	#主菜单功能：
Main_menu()
{
	clear
echo     "        图书馆管理系统 （0.1版本）"

echo    "            | 1.添加图书"
echo    "            | 2.删除图书"
echo    "            | 3.图书列表"
echo    "            | 4.查找图书"
echo    "            | q.返回退出"
echo  "-------------------------------"

read  -p  "请小主选择：" choice

case $choice in
	1)
		add_book		;;
	2)
		del_book		;;
	3)
		display_List	;;
	4)
		search_book 		;;
	q)
		reset
		exit      		;;
	*)
		Main_menu 		;;
esac
}
    #实现添加图书功能

add_book()
{
	clear
  echo  -e "开始录入图书信息\n" 
  read    -p "请输入图书的书名：" a b c d e f g h i j k l m n o #假设书名不会超过15字符、另外先不判断不输入情况
  	 	add_book_name=`echo " $a $b $c $d $e $f $g $h $i $j  $k $l $m $n $o"` #是取反
  	  echo -e "Bookname:$add_book_name\c" > add_book_temp

  read   -p "请输入图书的作者：" a b c d e f g h i j k l m n o #假设作者名字不会超过15字符、另外先不判断不输入情况
  	 	add_book_author=`echo  " $a $b $c $d $e $f $g $h $i $j  $k $l $m $n $o"` #是取反
  	  echo  -e " author:$add_book_author\c" >> add_book_temp

  read  -p "请输入图书的价格($)："  a b c d e f g h i j k l m n o #假设价格不会超过15字符、另外先不判断不输入情况
  	 	add_book_price=`echo  " $a $b $c $d $e $f $g $h $i $j  $k $l $m $n $o"` #是取反,也可用$
  	  echo -e " price:$add_book_price" >> add_book_temp  #注意这个地方不能有 /c 连接符号（否则对删除有影响）

  	    cat add_book_temp >> /root/library.txt
  	    rm -rf add_book_temp
  	  clear
  echo -e  "\n\n\t\t\t添加图书成功\n\n\n"

  echo -e "返回主目录:0   继续添加:1  查看图书列表:2  退出:q \n" 
  read -p "请小主选择：" choice_add_book
  case $choice_add_book  in
  	0)
  		Main_menu	 ;;
  	1)
  		add_book 	 ;;
  	2)
  	    display_List ;;
  		
  	q)
		clear
  		exit 	  	 ;;
  	*)
		Main_menu 	 ;;
  esac
}

	#实现图书删除操作

del_book()		#在这里只有通过图书名删除，通过序列号删除是最安全的，下一步实现
{
	clear
  echo  -e "！！敏感操作！！ 图书删除\n" 
  read  -t 15  -p "请小主输入图书名/作者名：" del_book_name

cat /root/library.txt | grep `echo -e $del_book_name` > del_book_temp
string=`cat del_book_temp`
  	 if [[ -z $string ]]; then           # -z 如果字符串（即输入）为空，则为真

  	 	rm -rf del_book_temp
  		echo -e "没有图书信息\n\n"
  	    echo -e "\t返回主目录:0   重新删除:1  退出:q \n" 
      	read -p "请小主选择：" choice_del_book
  			case $choice_del_book  in
			  	0)
			  		Main_menu ;;
			  	1)
			  		del_book  ;;
			  	q)
					clear
			  		exit 	  ;;
			  	*)
					Main_menu ;;
			 esac

		else
			clear
			 # display_Book_IF  此函数等会实现 展现删除图书信息
			 rm -rf del_book_temp
			 	echo  -e "!!敏感操作!! \n确认删除:Y  取消操作：N \n"
			   	read -p "请小主选择：" choice_Oper_book
			  			case $choice_Oper_book  in
						  	Y)
								#实际上是剔除所删除的图书后，存入另外一个文件夹，然后，再给文件夹改名字（也是替换）
								#方法不是很好，希望能有更好的方法。
								grep -v $del_book_name /root/library.txt > real_del_book_temp
								mv real_del_book_temp /root/library.txt 
							clear
								echo -e "已删除图书\n\n"
									  echo -e "返回主目录:0   继续删除:1  退出:q \n" 
									  read -p "请小主选择：" choice_del_next
									  case $choice_del_next  in
									  	0)
									  		Main_menu ;;
									  	1)
									  		del_book  ;;
									  	q)
											clear
									  		exit 	  ;;
									  	*)
											Main_menu ;;
									  esac
						  		 ;;
						  	N)
								clear
						  		Main_menu ;;

						  	*)
								Main_menu ;;
						 esac

  	 fi
  

}
	#实现图书列表
display_List()
{
	clear
	display_string=`cat /root/library.txt`
	clear                            # 这个清屏是不提示错误信息的作用 但是用&> /dev/dull 实现更好（语法忘了）
	if [[ -z $display_string ]]; then
			echo -e "图书列表为空\n\n"
			echo -e "返回主目录:0   添加图书:1  退出:q \n" 
	  		read -p "请小主选择：" choice_Error_display_List_book
	 		 case $choice_Error_display_List_book  in
	  			0)
	  				Main_menu ;;
	  			1)
	  				add_book  ;;
	  			q)
					clear
	  				exit 	  ;;
	  			*)
					Main_menu ;;
	 		 esac
	 else
	 	    echo -e "所有图书列表：\n\n"
			cat /root/library.txt | grep  "Bookname" 			 #不好，应该用awk实现
			echo -e "\n\n\t返回主目录:0   查看图书详细信息:1  退出:q \n" 
	  		read -p "请小主选择：" choice_Rrght_display_List_book
	 		 case $choice_Rrght_display_List_book  in
	  			0)
	  				Main_menu ;;
	  			1)
	  				search_book  ;;
	  			q)
					clear
	  				exit 	  ;;
	  			*)
					Main_menu ;;
	 		 esac
	 		
	fi
	
	#cut -d: -f 1,2 `echo -e $`
}
	#实现查找图书功能
	     查找：
     		0.用户输入图书信息（加入临时文件）
     		1.判断输入是否为空（为空提示错误并继续询问）
     		2.展现将要删除的图书信息（删除临时文件）
 			3.询问用户是否继续查找

search_book()
{
	clear
  echo  -e "查找图书\n" 
  read  -t 30  -p "请输入图书名：" search_book_name

cat /root/library.txt | grep `echo -e $search_book_name` > search_book_temp
string=`cat search_book_temp`
    clear
  	 if [[ -z $string ]]; then           # -z 如果字符串（即输入）为空，则为真

  	 	rm -rf search_book_temp
  		echo -e "没有图书信息/图书不存在\n\n"
  	    echo -e "\t返回主目录:0   重新查找:1  退出:q \n" 
      	read -p "请小主选择：" choice_search_book
  			case $choice_search_book  in
			  	0)
			  		Main_menu	 ;;
			  	1)
			  		search_book  ;;
			  	q)
					clear
			  		exit 	 	 ;;
			  	*)
					Main_menu 	 ;;
			 esac
	 else
	 		echo -e "\n\n\t\t\t--------------------"
	 	    echo -e "小主查询的图书信息：\n\n"
	 		cat search_book_temp
	 		rm -rf search_book_temp
			echo -e "\n\n\t返回主目录:0  继续查找:1  退出:q \n" 
	  		read -p "请小主选择：" choice_Rrght_display_List_book
	 		 case $choice_Rrght_display_List_book  in
	  			0)
	  				Main_menu ;;
	  			1)
	  				search_book  ;;
	  			q)
					clear
	  				exit 	  ;;
	  			*)
					Main_menu ;;
	 		 esac
  	 fi
}
Main_menu  #一定要放在最后面调用