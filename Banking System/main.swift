//
//  main.swift
//  Banking System
//
//  Created by SOMA SEKHAR ANAPARTHI on 20/02/21.
//

import Foundation
//*************   main function***************************//
var customers = [Customer]()
var users = 1000
var accountNos = 100000

func getCustomer(crn:String) -> Customer? {
    for i in customers{
        if i.crn == crn {
            return i
        }
    }
    return nil
}



func adddetails()
{
    users += 1
    let crn = String(users)
    
    print("Enter the Full Name")
    let fullname = readLine()!
    
    print("Enter the Father Name")
    let fname = readLine()!
    
    print("Enter the Date of Birth(DD-MM-YYYY)")
    let Dob = readLine()!
    
    print("Enter the occupation")
    let occupation = readLine()!
    
    print("Enter the phone number")
    let phNo = Int(readLine()!) ?? 1234567891
    
    print("Enter the Email ID")
    let email = readLine()!
    
    print("Enter the address")
    let address = readLine()!
    
    print("Enter the City")
    let city = readLine()!
    
    print("Enter the Pan Number")
    let panNo = readLine()!
    
    print("Enter the aadharNumber")
    let aadhar = readLine()!
    
    customers.append(Customer(crn:crn,fullName:fullname,fatherName:fname,DOB:Dob,occupation:occupation,phoneNumber:phNo,emailId:email,address:address,city:city,panNumber:panNo,aadharNumber:aadhar))
    
    
    let cus:Customer? = getCustomer(crn: crn)
    if cus != nil{
        var rep:Int
        repeat{
            rep = 0
            print("""
                \nSelect Account Type\n
                1.Savings:
                    Featues: -> Basic Account with minimum Balalce of 1000 Rupees.
                             -> Maximum withdrawl and deposit limit of 100000 Rupees.\n
                2.Savings Pro Account:
                    Featues: -> Pro Account with minimum Balalce of 2000 Rupees.
                             -> Maximum withdrawl and deposit limit of 200000 Rupees.\n
                3.Salary Account:
                    Features: -> For Salaried people no minimum balance
                              -> Maximum withdrawl and deposit limit of 100000 Rupees.\n
                Reply with 1 or 2 or 3 only.\n
                """)
            let account = Int(readLine()!) ?? 0
            print("Enter Initial Deposit Amount")
            let amount = Double(readLine()!) ?? 0.0
            accountNos += 1
            let accountNo = String(accountNos)
            if cus!.createAccount(type: account, accountNumber: accountNo, initialamount: amount) == false {
                rep = 1
            }
        }while rep == 1
        
        cus!.getData()
        
        print("Do You want to continue with \n 1:BANKING \n 2:Logout \nSelect 1 or 2")
        let choice = Int(readLine()!) ?? 0
        if choice == 1{
            banking(cus:cus!)
        }
    }
    
}


func banking(cus:Customer){
   
    print("\nPlease Select from below Transactions:\n 1:Check Balance\n 2.Deposit \n 3.Withdraw \n 4.Transfer\n 5.Pay Bills\n 6.Bookings\n 7.Exit\n")
    let transaction = Int(readLine()!) ?? 0
    switch transaction{
        case 1:
            if cus.getUserAccounts(){
                print("Please Select Account to Proceed")
                let account = Int(readLine()!) ?? 0
                cus.checkBalance(type:account)
            }
            
        case 2:
            if cus.getUserAccounts(){
                print("Please Select Account to Proceed")
                let account = Int(readLine()!) ?? 0
                print("Enter Amount")
                let amount = Double(readLine()!) ?? 0.0
                if cus.depositMoney(to:account,amount:amount) == false{
                    print("Money Deposit Unsuccessfull")
                }
            }
        case 3:
            if cus.getUserAccounts(){
                print("Please Select Account to Proceed")
                let account = Int(readLine()!) ?? 0
                print("Enter Amount")
                let amount = Double(readLine()!) ?? 0.0
                if cus.withdrawMoney(from:account,amount:amount) == false{
                    print("Money Withdrawl Unsuccessfull")
                }
            }
        case 4:
            if cus.getUserAccounts(){
                print("Select From Account")
                let fromAccount = Int(readLine()!) ?? 0
                print("Select To Account")
                let toAccount = Int(readLine()!) ?? 0
                print("Enter Amount")
                let amount = Double(readLine()!) ?? 0.0
                if cus.transfermoney(from:fromAccount,to:toAccount,amount:amount) == false{
                    print("Money Transfer Unsuccessfull")
                }
            }
        case 5:
            if cus.getUserAccounts(){
                var rep:Int
                print("Please Select Account to Proceed")
                let account = Int(readLine()!) ?? 0
                repeat{
                    rep = 0
                    if cus.paybills(from:account) == false{
                        rep = 1
                    }
                    print("\nDo You want to pay more Bills \n1:Yes \n2:Exit \n Select 1 or 2")
                    rep = Int(readLine()!) ?? 0
                }while rep == 1
            }
        case 6:
            if cus.getUserAccounts(){
                var rep:Int
                print("Please Select Account to Proceed")
                let account = Int(readLine()!) ?? 0
                repeat{
                    rep = 0
                    if cus.bookings(from:account) == false{
                        rep = 1
                    }
                    print("\nDo You want to do Book more \n1:Yes \n2:Exit \n Select 1 or 2")
                    rep = Int(readLine()!) ?? 0
                }while rep == 1
            }
        case 7:
            break
        default:
            print("**Please enter correct Choice**")
            banking(cus:cus)
      
    }
    
    print("\nDo You want to perform more Bank Transactions \n1:Yes \n2:Logout \n Select 1 or 2")
    let choice = Int(readLine()!) ?? 0
    if choice == 1{
        banking(cus:cus)
    }

}


func editdetails(cus:Customer){
    cus.getData()
    var rep:Int
    
    repeat {
        rep = 0
        print("Please Select Data to Update\nReply with Numbers from 1 to 10 only")
        let choice = Int(readLine()!) ?? 0
        
        switch choice {
        case 1:
            print("Please Enter Full Name to Update")
            cus.fullName = readLine()!
            print("Do you want to update more reply with 1 or reply with any other number")
            rep = Int(readLine()!) ?? 0
            
        case 2:
            print("Please Enter Father Name to Update")
            cus.fatherName = readLine()!
            print("Do you want to update more reply with 1 or reply with any other number")
            rep = Int(readLine()!) ?? 0
            
        case 3:
            print("Please Enter Date of Birth to Update")
            cus.dob = readLine()!
            print("Do you want to update more reply with 1 or reply with any other number")
            rep = Int(readLine()!) ?? 0
            
        case 4:
            print("Please Enter Occupation to Update")
            cus.occupation = readLine()!
            print("Do you want to update more reply with 1 or reply with any other number")
            rep = Int(readLine()!) ?? 0
            
        case 5:
            print("Please Enter Phone Number to Update")
            cus.phoneNumber = Int(readLine()!) ?? cus.phoneNumber
            print("Do you want to update more reply with 1 or reply with any other number")
            rep = Int(readLine()!) ?? 0
            
        case 6:
            print("Please Enter Email Id to Update")
            cus.emailId = readLine()!
            print("Do you want to update more reply with 1 or reply with any other number")
            rep = Int(readLine()!) ?? 0
            
        case 7:
            print("Please Enter Address to Update")
            cus.address = readLine()!
            print("Do you want to update more reply with 1 or reply with any other number")
            rep = Int(readLine()!) ?? 0
            
        case 8:
            print("Please Enter City to Update")
            cus.city = readLine()!
            print("Do you want to update more reply with 1 or reply with any other number")
            rep = Int(readLine()!) ?? 0
            
        case 9:
            print("Please Enter PAN Number to Update")
            cus.panNumber = readLine()!
            print("Do you want to update more reply with 1 or reply with any other number")
            rep = Int(readLine()!) ?? 0
            
        case 10:
            print("Please Enter Aadhar-Number to Update")
            cus.aadharNumber = readLine()!
            print("Do you want to update more reply with 1 or reply with any other number")
            rep = Int(readLine()!) ?? 0

        default:
            print("**Please enter correct Choice**")
            rep = 1
        }
        
    }while rep == 1
    
    cus.getData()
    
    print("Do You want to continue with \n1:BANKING \n 2.Exit \nSelect 1 or 2")
    let choice = Int(readLine()!) ?? 0
    if choice == 1{
        banking(cus:cus)
    }
    
}




//---------------------------------------User Starts from Here-------------------------------------------------//

while(true){
    print("**************   Helloo User Welcome to Cashing Cows Bank  *************")
    print("Choose from below\n 1: New User \n 2:Existing User \n Reply with 1 or 2 only")
    let choice = Int(readLine()!) ?? 0
    if choice == 1{
        print("\n--------------------------------------------------------------------------")
        print("Please enter your Basic Details to create an Account with us\n")
        adddetails()
    }else if choice == 2{
        print("\n--------------------------------------------------------------------------")
        print("Welcome")
        print("Enter Your Customer Relationship Number(CRN)")
        let crn = String(readLine()!)
        let cus:Customer? = getCustomer(crn: crn)
        if cus != nil{
            var re = 0
            print("\nHi \(cus!.fullName)")
            repeat{
                print("Please Select to Continue: \n 1:Edit Details \n 2:Banking \n3:Create Another Account\n")
                let choose = Int(readLine()!) ?? 0
                switch choose{
                case 1:
                    editdetails(cus: cus!)
                case 2:
                    banking(cus: cus!)
                case 3:
                    if cus != nil{
                        var rep:Int
                        repeat{
                            rep = 0
                            print("""
                                \nSelect Account Type
                                1.Savings:
                                    Featues: -> Basic Account with minimum Balalce of 1000 Rupees.
                                             -> Maximum withdrawl and deposit limit of 100000 Rupees.\n
                                2.Savings Pro Account:
                                    Featues: -> Pro Account with minimum Balalce of 2000 Rupees.
                                             -> Maximum withdrawl and deposit limit of 200000 Rupees.\n
                                3.Salary Account:
                                    Features: -> For Salaried people no minimum balance
                                              -> Maximum withdrawl and deposit limit of 100000 Rupees.\n
                                Reply with 1 or 2 or 3 only.
                                """)
                            let account = Int(readLine()!) ?? 0
                            print("\nEnter Initial Deposit Amount")
                            let amount = Double(readLine()!) ?? 0.0
                            accountNos += 1
                            let accountNo = String(accountNos)
                            if cus!.createAccount(type: account, accountNumber: accountNo, initialamount: amount) == false {
                                rep = 1
                            }
                        }while rep == 1
                        
                        print("\nDo You want to continue with \n1:BANKING \n2:Logout \n Select 1 or 2")
                        let choice = Int(readLine()!) ?? 0
                        if choice == 1{
                            banking(cus:cus!)
                        }
                    }
                default:
                    print("**Please enter correct Choice**")
                    re = 1
                }
            }while re == 1
        }else{
            print("No Customer Exists with Given Details")
        }
    }else {
        print("**Please enter correct Choice**")
    }
}


