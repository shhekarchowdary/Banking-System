//
//  User.swift
//  
//
//  Created by SOMA SEKHAR ANAPARTHI on 20/02/21.
//

import Foundation

class Customer
{
    var crn: String
    var fullName: String
    var fatherName: String
    var dob: String
    var occupation: String
    var phoneNumber: Int
    var emailId: String
    
    var address: String
    var city: String
    var panNumber :String
    var aadharNumber: String
    
    var account1: SavingsAccount?
    var account2: SavingsProAccount?
    var account3: SalaryAccount?
    
    init (crn:String,fullName:String,fatherName:String,DOB:String,occupation:String,phoneNumber:Int,emailId:String,address:String,city:String,panNumber:String,aadharNumber:String)
    {
        self.crn = crn
        self.fullName = fullName
        self.fatherName = fatherName
        self.dob = DOB
        self.occupation = occupation
        self.phoneNumber = phoneNumber
        self.emailId = emailId
        self.address = address
        self.city = city
        self.panNumber = panNumber
        self.aadharNumber = aadharNumber
        
        self.account1 = nil
        self.account2 = nil
        self.account3 = nil
    }

    
    func createAccount(type:Int, accountNumber:String, initialamount:Double) -> Bool{
        
        if getAccount(type: type) == nil {
            switch type
            {
                case 1:
                    if initialamount >= 0{
                        self.account1 = SavingsAccount(accountNumber:accountNumber, initialDeposit: initialamount)
                        print("Savings Account Creation Successful\nCurrent Balance: \(self.account1?.currentBalance ?? 0.0)\n")
                        return true
                    }else{
                        print("Minimum Balance for Savings Account is 0")
                        return false
                    }
                case 2:
                    if initialamount >= 2000{
                        self.account2 = SavingsProAccount(accountNumber:accountNumber, initialDeposit: initialamount)
                        print("Savings Pro Account Creation Successful\nCurrent Balance: \(self.account2?.currentBalance ?? 0.0)\n")
                        return true
                    }else{
                        print("Minimum Balance for Savings Account Pro is 2000")
                        return false
                    }
                case 3:
                    if initialamount >= 0{
                        print("Enter company name:")
                        let companyName = readLine()!
                        print("Enter Salary:")
                        let salary = Double(readLine()!)!
                        self.account3 = SalaryAccount(accountNumber:accountNumber, initialDeposit: initialamount, companyName: companyName, salary: salary)
                        print("Salary Account Creation Successful\nCurrent Balance: \(self.account3?.currentBalance ?? 0.0)\n")
                        return true
                    }else{
                        print("Minimum Balance for Salary Account is 0")
                        return false
                    }
                default:
                    print("**Please Enter Correct Account Type**")
                    return false
            }
        }else{
            print("**Entered Account Type already Exists for the user**")
            print("**Please Select Other Account Type to Create**")
            return false
        }
    }

    
    func getData()
    {
        print("---------------Customer Relationship Number(CRN):\(self.crn)-----------------")
        print("1.Customer Name:\(self.fullName)\n2.Father Name:\(self.fatherName)\n3.Date of Birth:\(self.dob)\n4.Occupation:\(self.occupation)\n5.Phone Number:\(self.phoneNumber)\n6.Email Id:\(self.emailId)\n7.Address:\(self.address)\n8.City:\(self.city)\n9.PAN-Number:\(self.panNumber) \n10.Aadhar-Number:\(self.aadharNumber)\n")
        print("You have following Accounts with us")
        if self.account1 != nil {
            print("Account No: \(account1!.accountNo)")
            print("Type: \(self.account1!.type)")
        }
        if self.account2 != nil {
            print("Account No: \(account2!.accountNo)")
            print("Type: \(self.account2!.type)")
        }
        if self.account3 != nil {
            print("Account No: \(account3!.accountNo)")
            print("Type: \(self.account3!.type)")
        }
        print("\n")
    }
    
    func getUserAccounts()->Bool{
        var count = 0
        if self.account1 != nil || self.account2 != nil || self.account3 != nil{
            print("\nYou have below Accounts with us")
            if self.account1 != nil {
                print("1.\(self.account1!.type)")
                count += 1
            }
            if self.account2 != nil {
                print("2.\(self.account2!.type)")
                count += 1
            }
            if self.account3 != nil {
                print("3.\(self.account3!.type)")
                count += 1
            }
            print("\nPlease reply with number")
            return true
        }else {
            return false
        }
                
    }
    
    func getAccount(type:Int) -> Account?{
        switch type
        {
            case 1:
                if self.account1 != nil{
                    return self.account1
                }else {
                    return nil
                }
            case 2:
                if self.account2 != nil{
                    return self.account2
                }else {
                    return nil
                }
            case 3:
                if self.account3 != nil{
                    return self.account3
                }else {
                    return nil
                }
            default:
                print("**Please Enter Correct Account type to Proceed**")
                return nil
        }
    }
    
    func checkBalance(type: Int)
    {
        let account = getAccount(type:type)
        if account != nil {
            print("Account Balance is: \(account!.currentBalance)")
        }else{
            print("**Customer Doesn't have selected Account**")
        }
    }
    
    func withdrawMoney(from:Int,amount:Double) -> Bool
    {
        let account = getAccount(type:from)
        if account != nil {
            if account!.withDraw(amount:amount) {
                print("Amount withdrawl succesfull")
                return true
            }else {
                return false
            }
        }else{
            print("Please Enter Correct Account Type")
                return false
        }
    }
    
    
    func depositMoney(to:Int,amount:Double)->Bool
    {
        let account = getAccount(type:to)
        if account != nil {
            if account!.deposit(amount:amount) {
                print("Amount deposit succesfull")
                return true
            }else {
                return false
            }
        }else{
            print("Please Enter Correct Account Type")
            return false
        }
    }
    
    
    func transfermoney(from:Int,to:Int,amount:Double)->Bool
    {
        var check = true
        if from != to
        {
            let wAccount = getAccount(type:from)
            if wAccount != nil
            {
                if amount <= wAccount!.currentBalance{
                    wAccount!.currentBalance -= amount
                    print("Current Balance in From Account:\(wAccount!.currentBalance)\n")
                    check = true
                }else{
                    print("Balance Insufficient in From Account \(wAccount!.currentBalance)\n")
                    check = false
                }
            }
            if check == true{
                let dAccount = getAccount(type:to)
                if dAccount != nil{
                        dAccount!.currentBalance += amount
                        print("Current Balance in to Account:\(dAccount!.currentBalance)\n")
                }
            }
        }
        else {
            check = false
            print("**The Sender and Beneficiary Accounts are same**")
        }
        return check
        
    }
    
    func paybills(from:Int) -> Bool
    {
        print("\nSelect:\n 1:Electricity Bill\n 2.BroadBand Bill \n 3.PostPaid Bill\n 4.Credit Bill\n 5.DTH Bill")
        let choice = Int(readLine()!)!
        switch choice{
        
            case 1:
                print("\nYour Electricity Bill is : 250")
                let account = getAccount(type:from)
                if account != nil {
                    if account!.withDraw(amount:250.0) {
                        print("Electricity Bill Payment Succesfull")
                        return true
                    }else {
                        return false
                    }
                }else{
                    return false
                }
            case 2:
                print("\nYour BroadBand Bill is : 599 ")
                let account = getAccount(type:from)
                if account != nil {
                    if account!.withDraw(amount:599.0) {
                        print("BroadBandBill Payment Succesfull")
                        return true
                    }else {
                        return false
                    }
                }else{
                    return false
                }
            case 3:
                print("\nYour Postpaid Bill is : 499 ")
                let account = getAccount(type:from)
                if account != nil {
                    if account!.withDraw(amount:499.0) {
                        print("BroadBandBill Payment Succesfull")
                        return true
                    }else {
                        return false
                    }
                }else{
                    return false
                }
            case 4:
                print("\nYour Credit Bill is : 1000 ")
                let account = getAccount(type:from)
                if account != nil {
                    if account!.withDraw(amount:1000.0) {
                        print("Credit Bill Payment Succesfull")
                        return true
                    }else {
                        return false
                    }
                }else{
                    return false
                }
            case 5:
                print("\nYour DTH Bill is : 450 ")
                let account = getAccount(type:from)
                if account != nil {
                    if account!.withDraw(amount:450.0) {
                        print("DTH Bill Payment Succesfull")
                        return true
                    }else {
                        return false
                    }
                }else{
                    return false
                }
            default:
                print("\nIncorrect Selection")
                return false
        }
        
    }
    
    func bookings(from:Int) -> Bool
    {
        print("\nSelect:\n 1:Movie Tickets \n 2.Travel Booking\n 3.Event Booking \n 4.Hotel Booking\n")
        let choice = Int(readLine()!)!
        switch choice{
        
            case 1:
                print("\nSelect Movie: \n1.Allari Alludu \n2.Dookudu \n3.Manmadhudu")
                _ = Int(readLine()!)!
                print("Your Ticket Fare is : 250 ")
                print("Booking Ticket...")
                let account = getAccount(type:from)
                if account != nil {
                    if account!.withDraw(amount:250.0) {
                        print("Booking Succesfull \n Theatre: ComedyCellar\t\t\tSeat No: H5")
                        return true
                    }else {
                        return false
                    }
                }else{
                    return false
                }
            case 2:
                print("\nSelect Mode of Travel: \n1.Flight \n2.Bus \n3.Train")
                _ = Int(readLine()!)!
                print("Enter Source:")
                _ = readLine()!
                print("Enter Destination:")
                _ = readLine()!
                print("Enter Date of Travel")
                _ = readLine()
                print("Your Ticket Fare is : 2000")
                print("Booking Ticket...")
                let account = getAccount(type:from)
                if account != nil {
                    if account!.withDraw(amount:2000.0) {
                        print("Booking Succesfull \n Booking ID: 8945679989")
                        return true
                    }else {
                        return false
                    }
                }else{
                    return false
                }
            case 3:
                print("\nSelect Event: \n1.Live Concert \n2.Naari Naari Naduma Murari \n3.Aada Pori Eeda Poragadu")
                _ = Int(readLine()!)!
                print("Your Ticket fare is : 500 ")
                print("Booking Ticket...")
                let account = getAccount(type:from)
                if account != nil {
                    if account!.withDraw(amount:500.0) {
                        print("Booking Succesfull \n Booking Id:143")
                        return true
                    }else {
                        return false
                    }
                }else{
                    return false
                }
            case 4:
                print("\nEnter City Name")
                _ = readLine()!
                print("Select Hotel: \n1.Novotel \n2.Taj \n3.ITC Kakatiya")
                _ = Int(readLine()!)!
                print("Enter Checkin Date")
                _ = readLine()!
                print("Number of Days")
                let days = Double(readLine()!) ?? 1
                let fare = days * 4500.0
                print("Your Booking Fare: \(fare)")
                print("Booking Hotel.....")
                let account = getAccount(type:from)
                if account != nil {
                    if account!.withDraw(amount:fare) {
                        print("Booking Succesfull \n Booking Id:143")
                        return true
                    }else {
                        return false
                    }
                }else{
                    return false
                }
            
            default:
                print("Incorrect Selection")
                return false
        }
    }
    
}
