
import Foundation

class Account
{
    var accountNo: String
    var currentBalance: Double = 0.0
    var minBalance: Double = 0.0
    var maxDeposit: Double = 0.0
    var maxWithdrawl: Double = 0.0
    var type: String = ""
    
    init (accountNumber:String,initialDeposit:Double){
        self.accountNo = accountNumber
        self.currentBalance = initialDeposit
    }
    
    func deposit(amount:Double) -> Bool{
        if amount <= self.maxDeposit {
            self.currentBalance += amount
            print("Current Balance:\(self.currentBalance)\n")
            return true
        }
        else{
            print("Your Account type can only deposit maximum of \(self.maxDeposit)\n")
            return false
        }
    }

     func withDraw(amount:Double) ->Bool{
        if amount <= currentBalance{
            if amount <= self.maxWithdrawl{
                self.currentBalance -= amount
                print("Current Balance:\(self.currentBalance)")
                return true
            }else{
                print("Your Account type can only withdraw maximum of \(self.maxWithdrawl)\n")
                return false
            }
        }else{
            print("Balance Insufficient \(self.currentBalance)\n")
            return false
        }
    }
    
    
}





class SavingsAccount: Account
{

    override init (accountNumber:String,initialDeposit:Double)
    {
        super.init(accountNumber:accountNumber,initialDeposit:initialDeposit)
        self.minBalance = 0.0
        self.maxDeposit = 100000.0
        self.maxWithdrawl = 100000.0
        self.type = "Savings Account"
    }
}







class SavingsProAccount: Account
{
    override init (accountNumber:String,initialDeposit:Double)
    {
        super.init(accountNumber:accountNumber,initialDeposit:initialDeposit)
        self.minBalance = 2000.0
        self.maxWithdrawl = 200000.0
        self.maxDeposit = 200000.0
        self.type = "Savings Pro Account"
        
    }
}





class SalaryAccount: Account
{
    var salary: Double
    var companyName: String
    
    init (accountNumber:String, initialDeposit:Double, companyName:String, salary:Double)
    {
        self.companyName = companyName
        self.salary = salary

        super.init(accountNumber:accountNumber,initialDeposit:initialDeposit)
        self.minBalance = 0.0
        self.maxDeposit = 150000.0
        self.maxWithdrawl = 150000.0
        self.type = "Salary Account"
        
    }
}
