#!/bin/bash
#图书管理系统
#作者：Lyons 
#日期： 2015/10/26
# superhookm@gmail.com


Welcome()
{
	reset
	echo  -e "\t\t\t\t \e[1;46m   欢迎进入图书管理系统-版本0.3   \e[0m"
	echo  -e "\n\n\n\n\n\n\n\n\n\n\t\t\t\t\t\e[1;31m Enter 图书管理系统\e[0m"
	read 
	Main_menu
}
quit_saybaby()
{
	clear
	echo  -e "\t\t\t\t \e[1;46m   欢迎惠顾图书管理系统-版本0.1   \e[0m"
	echo  -e "\n\n\n\n\n\n\n\n\n\n\t\t\t\t\t\e[1;31m EXIT 图书管理系统\e[0m"
	echo  -e "\n\n\n\n\n\n\t\t\t\t\t\e[1;31m   谢谢您的使用\e[0m"
	read  -t 2

	reset
	exit

}
	#主菜单功能：
Main_menu()
{
	clear
echo  -e "\t\t\t\t \e[1;46m   图书管理系统-版本0.3   \e[0m"
echo  -e "\n\n\n"

echo  -e  "\t\t\t\t\t\e[1;29m| 1.添加图书"
echo  -e  "\t\t\t\t\t| 2.删除图书"
echo  -e  "\t\t\t\t\t| 3.图书列表"
echo  -e  "\t\t\t\t\t| 4.查找图书"
echo  -e  "\t\t\t\t\t\e[1;29m| q.返回退出\e[0m"
echo  -e  "\e[1;31m---------------\e[0m"
read  -p  "请小主选择：" choice

case $choice in
	1)
		add_book		;;
	2)
		del_book		;;
	3)
		display_List	;;
	4)
		search_book 	;;
	q)
		clear
		quit_saybaby   	;;
	*)
		Main_menu 		;;
esac
}
    #实现添加图书功能

add_book()
{
clear
echo  -e "\t\t\t\t \e[1;46m   图书管理系统-版本0.3   \e[0m"
  echo  -e "\n\n\n开始录入图书信息\n" 
  read    -p "请输入图书的书名：" a b c d e f g h #假设书名不会超过15字符、另外先不判断不输入情况
  	 	add_book_name=`echo "$a $b $c $d $e $f $g $h"` #是取反
  	  echo -e "Bookname:$add_book_name\c" > add_book_temp
  read   -p "请输入图书的作者：" a b c d e f g h #假设作者名字不会超过15字符、另外先不判断不输入情况
  	 	add_book_author=`echo  "$a $b $c $d $e $f $g $h"` #是取反
  	  echo  -e " Author:$add_book_author\c" >> add_book_temp
  read    -p "请输入图书的编号：" a b c d e f g h #假设书名不会超过15字符、另外先不判断不输入情况
  	 	add_book_number=`echo "$a $b $c $d $e $f $g $h"` #是取反
  	  echo -e "Number:$add_book_number\c" >> add_book_temp

  read  -p "请输入图书的价格($)："  a b c d e f g h #假设价格不会超过15字符、另外先不判断不输入情况
  	 	add_book_price=`echo  "$a $b $c $d $e $f $g $h"` #是取反,也可用$
  	  echo -e " Price:$add_book_price" >> add_book_temp  #注意这个地方不能有 /c 连接符号（否则对删除有影响）

  	    cat add_book_temp >> /root/library.txt
  	    rm -rf add_book_temp
  	  clear
  echo  -e "\t\t\t\t \e[1;46m   图书管理系统-版本0.3   \e[0m"
  echo -e  "\n\n\t\t\t\t\e[1;31m       添加图书成功\e[0m\n\n\n"

  echo -e "返回主目录:0   继续添加:1  查看图书列表:2  退出:q \n" 
  echo  -e  "\e[1;31m---------------\e[0m"
  read -p "请小主选择：" choice_add_book
  case $choice_add_book  in
  	0)
  		Main_menu	  ;;
  	1) 
  		add_book 	  ;;
  	2)
  	    display_List  ;;
  		
  	q)
		clear
  		quit_saybaby  ;;
  	*)
		Main_menu 	  ;;
  esac
}

	#实现图书删除操作

del_book()		#在这里只有通过图书名删除，通过序列号删除是最安全的，下一步实现
{
clear
echo  -e "\t\t\t\t \e[1;46m   图书管理系统-版本0.3   \e[0m"
  echo  -e "\n\n\n\t\t\t\t\e[1;35m ！！敏感操作 图书删除！！\e[0m\n" 
  read  -t 15  -p "请小主输入图书编号：" del_book_namee
  temp="Number:"
  del_book_name=${temp}${del_book_namee}                              #追加字符串，和查找功能一樣
cat /root/library.txt | grep `echo -e $del_book_name` >> del_book_temp
string=`cat del_book_temp`
  	 if [[ -z $string ]]; then           # -z 如果字符串（即输入）为空，则为真

  	 	rm -rf del_book_temp
  		echo -e "\n\e[1;35m 没有图书信息/图书不存在 \e[0m \n\n"
  	    echo -e "\t返回主目录:0   重新删除:1  退出:q \n" 
  	    echo  -e  "\e[1;31m---------------\e[0m"
      	read -p "请小主选择：" choice_del_book
  			case $choice_del_book  in
			  	0)
			  		Main_menu 	 ;;
			  	1)
			  		del_book 	 ;;
			  	q)
					clear
			  		quit_saybaby ;;
			  	*)
					Main_menu 	 ;;
			 esac

		else
			clear
			 # display_Book_IF  此函数等会实现 展现删除图书信息
			 rm -rf del_book_temp
			    echo  -e "\n\n\n\t\t\t\t\t\e[1;35m ！！敏感操作  图书删除！！ \e[0m\n" 
			 	echo  -e "\t\t\t\t\t  确认删除:Y   取消操作：N \n"
			 	echo  -e  "\e[1;31m---------------\e[0m"
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
									  echo  -e  "\e[1;31m---------------\e[0m"
									  read -p "请小主选择：" choice_del_next
									  case $choice_del_next  in
									  	0)
									  		Main_menu	  ;;
									  	1)
									  		del_book  	  ;;
									  	q)
											clear
									  		quit_saybaby  ;;
									  	*)
											Main_menu 	  ;;
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
	echo  -e "\t\t\t\t \e[1;46m   图书管理系统-版本0.3   \e[0m"
	display_string=`cat /root/library.txt`
	clear                            # 这个清屏是不提示错误信息的作用 但是用&> /dev/dull 实现更好（语法忘了）
	if [[ -z $display_string ]]; then
			echo -e "图书列表为空\n\n"
			echo -e "返回主目录:0   添加图书:1  退出:q \n" 
			echo  -e  "\e[1;31m---------------\e[0m"
	  		read -p "请小主选择：" choice_Error_display_List_book
	 		 case $choice_Error_display_List_book  in
	  			0)
	  				Main_menu	 ;;
	  			1)
	  				add_book   	 ;;
	  			q)
					clear
	  				quit_saybaby ;;
	  			*)
					Main_menu 	 ;;
	 		 esac
	 else
	 		echo  -e "\t\t\t\t \e[1;46m   图书管理系统-版本0.3   \e[0m"
	 	    echo -e "所有图书列表：\n\n"
			cat /root/library.txt | grep  "Bookname" 			 #不好，应该用awk实现
			echo -e "\n\n\t 返回主目录:0   查看图书详细信息:1  退出:q \n" 
			echo  -e  "\e[1;31m---------------\e[0m"
	  		read -p "请小主选择：" choice_Rrght_display_List_book
	 		 case $choice_Rrght_display_List_book  in
	  			0)
	  				Main_menu 		;;
	  			1)
	  				search_book  	;;
	  			q)
					clear
	  				quit_saybaby	;;
	  			*)
					Main_menu	    ;;
	 		 esac
	 		
	fi
	
	#cut -d: -f 1,2 `echo -e $`
}
	
	#实现查找图书功能

search_book()
{
  clear
echo  -e "\t\t\t\t \e[1;46m   图书管理系统-版本0.3   \e[0m"
echo  -e "\n\n\n"

echo  -e  "\t\t\t\t\e[1;21m   | 1.按图书 编号 查询"
echo  -e  "\t\t\t\t   | 2.按图书 作者 查询"
echo  -e  "\t\t\t\t   | 3.按图书 书名 查询"
echo  -e  "\t\t\t\t   | 4.按图书 价格 查询"
echo  -e  "\t\t\t\t\e[1;32m   | 0.返回主目录\e[0m"
echo  -e  "\e[1;31m---------------\e[0m"
read  -p  "请小主选择：" search_choice

case $search_choice in
	
	1)				 
clear
  echo  -e "\t\t\t\t \e[1;46m   图书管理系统-版本0.3   \e[0m"
  echo  -e "\n\n正在查找图书\n" 
  read  -t 30  -p "请输入图书编号：" search_BookNumm
   temp="Number:"
  search_BookNum=${temp}${search_BookNumm}
	cat /root/library.txt | grep `echo -e $search_BookNum` > search_book_temp
	search_Book_IfEcho	;;  #交给判断函数处理剩余步骤
	
	2)		 
clear
  echo  -e "\t\t\t\t \e[1;46m   图书管理系统-版本0.3   \e[0m"
  echo  -e "\n\n正在查找图书\n" 
  read  -t 30  -p "请输入图书作者：" search_BookAuthorr
  temp="Author:"
   search_BookAuthor=${temp}${search_BookAuthorr}
	cat /root/library.txt | grep `echo -e $search_BookAuthor` > search_book_temp
	search_Book_IfEcho	;;  #交给判断函数处理剩余步骤;;
	
	3)		
clear
  echo  -e "\t\t\t\t \e[1;46m   图书管理系统-版本0.3   \e[0m"
  echo  -e "\n\n正在查找图书\n" 
  read  -t 30  -p "请输入图书书名：" search_Booknamee
  temp="Bookname:"
  search_Bookname=${temp}${search_Booknamee}
	cat /root/library.txt | grep `echo -e $search_Bookname` > search_book_temp
	search_Book_IfEcho	;;  #交给判断函数处理剩余步骤;;
	
	4)
		 	
clear
  echo  -e "\t\t\t\t \e[1;46m   图书管理系统-版本0.3   \e[0m"
  echo  -e "\n\n正在查找图书\n" 
  read  -t 30  -p "请输入图书价格：" search_BookPricee
  temp="Price:"
  search_BookPrice=${temp}${search_BookPricee}
	cat /root/library.txt | grep `echo -e $search_BookPrice` > search_book_temp
	search_Book_IfEcho	;;  #交给判断函数处理剩余步骤;;
	0)
		clear
		Main_menu  			 ;;
	*)
		search_book			 ;;
esac 
}

#实现判断查找图书中输入的值是否正确，以及下一步的处理功能

search_Book_IfEcho()
{
	string=`cat search_book_temp`
  	 if [[ -z $string ]]; then           # -z 如果字符串（即输入）为空，则为真

  	 	rm -rf search_book_temp
  		echo -e "\n\e[1;35m 没有图书信息/图书不存在 \e[0m \n\n"
  	    echo -e "\t返回主目录:0   重新查找:1  退出:q \n" 
  	    echo  -e  "\e[1;31m---------------\e[0m"
      	read -p "请小主选择：" choice_search_book
  			case $choice_search_book  in
			  	0)
			  		Main_menu	 ;;
			  	1)
			  		search_book  ;;
			  	q)
					clear
			  		quit_saybaby ;;
			  	*)
					search_book  ;;
			 esac
	 else
	 	    echo -e "\n查询的图书信息：\n\n"
	 		cat search_book_temp
	 		rm -rf search_book_temp
			echo -e "\n\n\t\t返回主目录:0  继续查找:1  退出:q \n" 
			echo  -e  "\e[1;31m---------------\e[0m"
	  		read -p "请小主选择：" choice_Rrght_display_List_book
	 		 case $choice_Rrght_display_List_book  in
	  			0)
	  				Main_menu 		;;
	  			1)
	  				search_book     ;;
	  			q)
					clear
	  				quit_saybaby    ;;
	  			*)
					Main_menu 		;;
	 		 esac
  	 fi
}
Welcome  #一定要放在最后面调用