//
//  User.swift
//  
//
//  Created by SOMA SEKHAR ANAPARTHI on 20/02/21.
//

import Foundation

class Customer
{
    var cin: String
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
    
    init (cin:String,fullName:String,fatherName:String,DOB:String,occupation:String,phoneNumber:Int,emailId:String,address:String,city:String,panNumber:String,aadharNumber:String)
    {
        self.cin = cin
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
                        print("Account Creation Unsuccessfull")
                        print("Amount must be not Negative")
                        return false
                    }
                case 2:
                    if initialamount >= 2000{
                        self.account2 = SavingsProAccount(accountNumber:accountNumber, initialDeposit: initialamount)
                        print("Savings Pro Account Creation Successful\nCurrent Balance: \(self.account2?.currentBalance ?? 0.0)\n")
                        return true
                    }else{
                        print("Account Creation Unsuccessfull")
                        print("Minimum Balance for Savings Account Pro is 2000")
                        return false
                    }
                case 3:
                    if initialamount >= 0{
                        print("Enter company name:")
                        let companyName = readLine()!
                        print("Enter Employee Id:")
                        let empId = readLine()!
                        self.account3 = SalaryAccount(accountNumber:accountNumber, initialDeposit: initialamount, companyName: companyName, empId: empId)
                        print("Salary Account Creation Successful\nCurrent Balance: \(self.account3?.currentBalance ?? 0.0)\n")
                        return true
                    }else{
                        print("Account Creation Unsuccessfull")
                        print("Amount must be not Negative")
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
        print("---------------Customer Identification Number(CIN):\(self.cin)-----------------")
        print("1.Customer Name:\(self.fullName)\n2.Father Name:\(self.fatherName)\n3.Date of Birth:\(self.dob)\n4.Occupation:\(self.occupation)\n5.Phone Number:\(self.phoneNumber)\n6.Email Id:\(self.emailId)\n7.Address:\(self.address)\n8.City:\(self.city)\n9.PAN-Number:\(self.panNumber) \n10.Aadhar-Number:\(self.aadharNumber)\n")
        print("Customer have following Accounts with us")
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
            print("Company Name: \(self.account3!.companyName)")
            print("Employee Id: \(self.account3!.empId)")
        }
    }
    
    func getUserAccounts()->Bool{
        var count = 0
        if self.account1 != nil || self.account2 != nil || self.account3 != nil{
            print("\nCustomer have Following Accounts with us")
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
            print("\nPlease Select Account type")
            return true
        }else {
            print("Customer have No accounts Created")
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
                print("Amount withdrawal successfull")
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
                print("Amount deposit successfull")
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
            let wAccount = getAccount(type:from)
            let dAccount = getAccount(type:to)
            if wAccount != nil
            {
                if dAccount != nil{
                    if amount <= wAccount!.currentBalance{
                        wAccount!.currentBalance -= amount
                        print("Current Balance in \(wAccount!.type):\(wAccount!.currentBalance)\n")
                        check = true
                    }else{
                        print("Balance Insufficient in \(wAccount!.type) \(wAccount!.currentBalance)\n")
                        check = false
                    }
                    if check == true{
                        let dAccount = getAccount(type:to)
                        if dAccount != nil{
                                dAccount!.currentBalance += amount
                                print("Current Balance in \(dAccount!.type):\(dAccount!.currentBalance)\n")
                        }
                    }
                }else{
                    print("Beneficiary Account Doesn't Exists")
                }
            }else{
                print("Sender Account Doesn't Exists")
            }
            
        return check
    }
    
    func paybills(from:Int) -> Bool
    {
        print("\nChoose anyone from below:\n 1:Electricity Bill\n 2.BroadBand Bill \n 3.PostPaid Bill\n 4.Credit Bill\n 5.DTH Bill")
        let choice = Int(readLine()!) ?? 0
        switch choice{
        
            case 1:
                print("\nPlease enter Electricity Bill Id")
                _ = readLine()!
                let randomInt = Int.random(in: 100..<1000)
                let bill = Double(randomInt)
                print("\nYour Electricity Bill is : \(bill)")
                print("\nDo you want to pay\n 1:Yes\n 2:No\nSelect 1 or 2 only")
                let ans = Int(readLine()!) ?? 0
                if ans == 1{
                    let account = getAccount(type:from)
                    if account != nil {
                        if account!.withDraw(amount:bill) {
                            print("Electricity Bill Payment Succesfull")
                            return true
                        }else {
                            return false
                        }
                    }else{
                        return false
                    }
                }else {
                    return false
                }
                
            case 2:
                print("\nPlease enter Broadband Bill Id")
                _ = readLine()!
                let randomInt = Int.random(in: 500..<1000)
                let bill = Double(randomInt)
                print("\nYour BroadBand Bill is : \(bill) ")
                print("\nDo you want to pay\n 1:Yes\n 2:No\nSelect 1 or 2 only")
                let ans = Int(readLine()!) ?? 0
                if ans == 1{
                    let account = getAccount(type:from)
                    if account != nil {
                        if account!.withDraw(amount:bill) {
                            print("BroadBandBill Payment Succesfull")
                            return true
                        }else {
                            return false
                        }
                    }else{
                        return false
                    }
                }else {
                    return false
                }
                
            case 3:
                print("\nPlease enter Pospaid Bill Id")
                _ = readLine()!
                let randomInt = Int.random(in: 500..<1000)
                let bill = Double(randomInt)
                print("\nYour Postpaid Bill is : \(bill)")
                print("\nDo you want to pay\n 1:Yes\n 2:No\nSelect 1 or 2 only")
                let ans = Int(readLine()!) ?? 0
                if ans == 1{
                    let account = getAccount(type:from)
                    if account != nil {
                        let account = getAccount(type:from)
                        if account != nil {
                            if account!.withDraw(amount:bill) {
                                print("BroadBandBill Payment Succesfull")
                                return true
                            }else {
                                return false
                            }
                        }else{
                            return false
                        }
                    }else {
                        return false
                    }
                }else {
                    return false
                }
                
                
            case 4:
                let randomInt = Int.random(in: 0..<2000)
                let bill = Double(randomInt)
                print("\nYour Credit Bill is : \(bill) ")
                print("\nDo you want to pay\n 1:Yes\n 2:No\nSelect 1 or 2 only")
                let ans = Int(readLine()!) ?? 0
                if ans == 1{
                    let account = getAccount(type:from)
                    if account != nil {
                        if account!.withDraw(amount:bill) {
                            print("Credit Bill Payment Succesfull")
                            return true
                        }else {
                            return false
                        }
                    }else{
                        return false
                    }
                }else{
                    return false
                }
                
            case 5:
                print("\nPlease enter DTH Bill Id")
                _ = readLine()!
                let randomInt = Int.random(in: 250..<700)
                let bill = Double(randomInt)
                print("\nYour DTH Bill is : \(bill) ")
                print("\nDo you want to pay\n 1:Yes\n 2:No\nSelect 1 or 2 only")
                let ans = Int(readLine()!) ?? 0
                if ans == 1{
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
        print("\nChoose anyone from below:\n 1:Movie Tickets \n 2.Travel Booking\n 3.Event Booking \n 4.Hotel Booking\n")
        let choice = Int(readLine()!)!
        switch choice{
        
            case 1:
                print("\nSelect Movie:\n 1.Avengers End Game\n 2.Tenet\n 3.Wonder Woman\n 4.Joker")
                _ = Int(readLine()!) ?? 2
                print("Enter No of Tickets")
                let num = Double(readLine()!) ?? 1.0
                print("Each Ticket Fare is : 250 ")
                print("Total Fare:\(250*num)")
                print("\nDo you want to pay\n 1:Yes\n 2:No\nSelect 1 or 2 only")
                let ans = Int(readLine()!) ?? 0
                if ans == 1{
                    print("Booking Ticket...")
                    let account = getAccount(type:from)
                    if account != nil {
                        if account!.withDraw(amount:250.0*num) {
                            print("Booking Succesfull \n Theatre: Cineplex\t\t\tSeat No: H5")
                            return true
                        }else {
                            return false
                        }
                    }else{
                        return false
                    }
                }else{
                    return false
                }
                
            case 2:
                print("\nSelect Mode of Travel: \n1.Flight \n2.Bus \n3.Train")
                _ = Int(readLine()!) ?? 2
                print("Enter Source City:")
                _ = readLine()!
                print("Enter Destination City:")
                _ = readLine()!
                print("Enter Date of Travel")
                _ = readLine()
                let randomInt = Int.random(in: 1000..<5000)
                let fare = Double(randomInt)
                print("Your Ticket Fare is : \(fare)")
                print("\nDo You want to pay\n 1:Yes\n 2:No\nSelect 1 or 2")
                let ans = Int(readLine()!) ?? 0
                if ans == 1{
                    print("Booking Ticket...")
                    let account = getAccount(type:from)
                    if account != nil {
                        if account!.withDraw(amount:fare) {
                            print("Booking Succesfull \n Booking ID: \(Int.random(in: 11111..<99999))")
                            return true
                        }else {
                            return false
                        }
                    }else{
                        return false
                    }
                }else{
                    return false
                }
                
            case 3:
                print("\nSelect an Event: \n1.Chainsmokers Live Concert \n2.AUS vs IND ODI-1 \n3.The Grand Carnival Exhibition")
                _ = Int(readLine()!) ?? 3
                let randomInt = Int.random(in: 250..<700)
                let fare = Double(randomInt)
                print("Your Ticket fare is : \(fare)")
                print("\nDo you want to pay\n 1:Yes\n 2:No\nSelect 1 or 2 only")
                let ans = Int(readLine()!) ?? 0
                if ans == 1{
                    print("Booking Ticket...")
                    let account = getAccount(type:from)
                    if account != nil {
                        if account!.withDraw(amount:fare) {
                            print("Booking Succesfull \n Booking Id:\(Int.random(in: 111..<999))")
                            return true
                        }else {
                            return false
                        }
                    }else{
                        return false
                    }
                }else{
                    return false
                }
                
            case 4:
                print("\nEnter City Name")
                _ = readLine()!
                print("Select Hotel: \n1.Novotel \n2.Taj \n3.ITC Kakatiya")
                _ = Int(readLine()!) ?? 1
                print("Enter Checkin Date")
                _ = readLine()!
                print("Number of Days")
                let days = Double(readLine()!) ?? 1
                let randomInt = Int.random(in: 3500..<4500)
                let dayFare = Double(randomInt)
                let fare = days * dayFare
                print("Your Booking Fare: \(fare)")
                print("\nDo you want to pay\n 1:Yes\n 2:No\nSelect 1 or 2 only")
                let ans = Int(readLine()!) ?? 0
                if ans == 1{
                    print("Booking Hotel.....")
                    let account = getAccount(type:from)
                    if account != nil {
                        if account!.withDraw(amount:fare) {
                            print("Booking Succesfull \n Booking Id:\(Int.random(in: 1111..<9999))")
                            return true
                        }else {
                            return false
                        }
                    }else{
                        return false
                    }
                }else{
                    return false
                }
            
            default:
                print("**Incorrect Selection**")
                return false
        }
        
      }
    
    }
