# This is a calculator for profit scaling when buying and selling put options. 

function Calculate-PutProfitability {
    param (
        [float]$PremiumPreShare, # Premium received pre share
        [int]$NumberOfShares, # Number of shares (typically 100 for 1 contract)
        [float]$StrikePrice, #Price at which you'd buy the stock (stock price)
        [float]$CurrentPrice # Current stock price at purchase
    )
    
    # Total Premium received
    $TotalPremium = $PremiumPerShare * $NumberOfShares

    # Scenario 1: Put expires worthless (stock stays above strike price)
    $ProfitIfExpeired = $TotalPremium

    # Scenario 2: You purchase the stock (stock drops to or below strike price)
    $CostToBuyStock = $StrikePrice * $NumberOfShares
    $ProfitIfStockPurchased = $TotalPremium
    $ROIifStockPurchased = ($ProfitIfStockPurchased / $CostToBuyStock) * 100

    #Output Results
    return @{
        "Total Premium Earned" = $TotalPremium
        "Scenario 1 (Put Expires)" = @{
            "Profit" = $ProfitIfExpeired
            "ROI (%)" = [System.Math]::Round($ROIIFExpired, 2)
        }
        "Scenario 2(Stock Purchased)" = @{
            "Profit" = $ProfitIfStockPurchased
            "ROI (%)" = [System.Math]::Round($ROIifStockPurchased, 2)
        }
        "Cost to buy stock" = $CostToBuyStock
    }

}

<#
# Example Usage
$PremiumPerShare = 0.25      # Example: $0.25 premium per share
$NumberOfShares = 100        # Example: 1 contract = 100 shares
$StrikePrice = 17            # Example: Strike price is $17
$CurrentPrice = 20           # Example: Current stock price is $20
#>

Write-Host "First you need to provide values"
$PremiumPerShare = Read-Host "Provide  Premium received per share: "
$NumberOfShares = Read-Host "Provide  Number of shares (usually 100 for 1 contract): "
$StrikePrice = Read-Host "Provide Price at which you'd buy the stock (strike price): "
$CurrentPrice = Read-Host "Provide Current price of stock: "

$results = Calculate-PutProfitability -PremiumPerShare $PremiumPerShare -NumberOfShares $NumberOfShares -StrikePrice $StrikePrice -CurrentPrice $CurrentPrice
$results | Format-List