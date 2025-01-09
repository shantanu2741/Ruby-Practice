def divide_expense(ggid)
  group = find_by_gid(ggid)
  if group
    members = @users.select { |user| user.gid == ggid }
    if members.empty?
      puts "No members in the group to divide the expense."
      return
    end

    split_amount = group.amount / members.size
    members.each do |member|
      member.balance -= split_amount
    end

    puts "Expense of #{group.amount} divided equally among #{members.size} members. Each owes #{split_amount}."
  else
    puts "Group not found."
  end
end
def view_group_members(ggid)
  group = find_by_gid(ggid)
  if group
    members = @users.select { |user| user.gid == ggid }
    if members.empty?
      puts "No members in this group."
    else
      puts "Members of group #{group.gname}:"
      members.each { |member| puts member }
    end
  else
    puts "Group not found."
  end
end
def remove_member_from_group(ggid)
  group = find_by_gid(ggid)
  if group
    puts "Enter the user ID to remove from the group:"
    user_id = gets.chomp.to_i
    user = @users.find { |u| u.id == user_id && u.gid == ggid }

    if user
      user.gid = 0
      puts "User #{user.name} removed from group #{group.gname}."
    else
      puts "User not found in this group."
    end
  else
    puts "Group not found."
  end
end
loop do
  puts "--------------------------------------"
  puts "Enter 1 to add members to group:"
  puts "Enter 2 to view group members:"
  puts "Enter 3 to add expenses:"
  puts "Enter 4 to divide expenses among members:"
  puts "Enter 5 to remove a member from group:"
  puts "Enter 6 to exit"
  puts "--------------------------------------"
  puts "Enter your choice:"

  opt = gets.chomp.to_i
  break if opt == 6

  if opt == 1
    manageuser.add_members_to_group(gid)
  elsif opt == 2
    manageuser.view_group_members(gid)
  elsif opt == 3
    manageuser.add_amount(gid)
  elsif opt == 4
    manageuser.divide_expense(gid)
  elsif opt == 5
    manageuser.remove_member_from_group(gid)
  else
    puts "Invalid option."
  end
end
