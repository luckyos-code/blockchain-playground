// Token ICO

// Compiler version
pragma solidity >=0.4.22 <0.7.0;

contract token_ico {
    
    // Define max/total number of Tokens
    uint public max_tokens = 1000000;
    
    // USD to Tokens conversion rate
    uint public usd_to_tokens = 1000;
    
    // Number of Tokens bought by investors
    uint public total_tokens_bought = 0;
    
    // Mapping from investor address to equity in Tokens and USD
    mapping(address => uint) equity_tokens;
    mapping(address => uint) equity_usd;
    
    // Check if investor can buy Tokens (check if some are left)
    modifier can_buy_tokens(uint usd_invested) {
        require (usd_invested * usd_to_tokens + total_tokens_bought <= max_tokens);
        _;
    }
    
     // Check if investor can sell Tokens (check if he has enough)
    modifier can_sell_tokens(address investor, uint tokens_sold) {
        require (equity_tokens[investor] <= tokens_sold);
        _;
    }
    
    // Functions for MyEtherWallet
    
    // Get equity in Tokens (using the mapping)
    function equity_in_tokens(address investor) external view returns (uint) {
        return equity_tokens[investor];
    }
    
    // Get equity in USD (using the mapping)
     function equity_in_usd(address investor) external view returns (uint) {
        return equity_usd[investor];
    }
    
    // Buy Tokens
    function buy_tokens(address investor, uint usd_invested) external
    can_buy_tokens(usd_invested) {
        uint tokens_bought = usd_invested * usd_to_tokens;
        equity_tokens[investor] += tokens_bought;
        equity_usd[investor] = equity_tokens[investor] / usd_to_tokens;
        total_tokens_bought += tokens_bought;
    }
    
    // Sell Tokens
    function sell_tokens(address investor, uint tokens_sold) external
    can_sell_tokens(investor, tokens_sold) {
        equity_tokens[investor] -= tokens_sold;
        equity_usd[investor] = equity_tokens[investor] / usd_to_tokens;
        total_tokens_bought -= tokens_sold;
    }
    
}