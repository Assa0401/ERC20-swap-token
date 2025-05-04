// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts@4.9.2/token/ERC20/ERC20.sol";

interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowacance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}

interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}

interface IUniswapV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

contract Open_Voice is ERC20 {
    
    IUniswapV2Router02 public uniswapV2Router;
    address public uniswapV2Pair;
    
    // The operator is NOT the owner, is the operator of the machine
    address public operator;

    // Addresses excluded from fees
    mapping (address => bool) public isExcludedFromFee;
    mapping (address => bool) public isExcludedFromLimit;

    mapping (address => bool) public automatedMarketMakerPairs;

    // tax Fee Wallet address
    address public feeWallet;
    
    uint256 public buyFee = 300;
    uint256 public sellFee = 300;   // default 3%, decimal 2
    uint256 public totalsupply = 10 ** 9 * 10 ** 18;

    // Burn address
    address public constant BURN_ADDRESS = 0x000000000000000000000000000000000000dEaD; // INMUTABLE

    address public constant V2ROUTER = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;

    // Events before Governance
    event OperatorTransferred(address indexed previousOperator, address indexed newOperator);
    event SetAutomatedMarketMakerPair(address indexed pair, bool indexed value);
    event UpdateFeeWallet(address indexed walletAddress);
    event UpdateBuyFee(uint256 buyFee);
    event UpdateSellFee(uint256 sellFee);


    // Operator CAN do modifier
    modifier onlyOperator() {
        require(operator == msg.sender, "Test:: operator: caller is not the operator");
        _;
    }

    /**z
     * @notice Constructs the Test token contract.
     */
    constructor(address _owner, address _feeWallet) ERC20("Open Voice Network", "NETOVC") {
        operator = _msgSender();
        emit OperatorTransferred(address(0), operator);
        
        IUniswapV2Router02 _uniswapV2Router = IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
        uniswapV2Router = _uniswapV2Router;
        uniswapV2Pair = IUniswapV2Factory(_uniswapV2Router.factory()).createPair(address(this), _uniswapV2Router.WETH());

        _setAutomatedMarketMakerPair(address(uniswapV2Pair), true);

        require(_feeWallet != address(0), "Test:: Wallet address is zero");
        feeWallet = _feeWallet;

        setExcludeFromFee(_owner, true);
        setExcludeFromFee(address(this), true);
        setExcludeFromFee(address(BURN_ADDRESS), true);

        setExcludeFromLimit(uniswapV2Pair, true);
        setExcludeFromLimit(_owner, true);

        super._mint(_owner, totalsupply);
    }

    mapping (address => uint256) private _lastTime;


    /// @dev overrides transfer function to meet tokenomics of Test
    function _transfer(address sender, address recipient, uint256 amount) internal override virtual {
        // Pre-flight checks
        require(amount > 0, "Test:: Amount must be greater than zero");
        require(balanceOf(recipient) + amount < totalsupply * 5 / 100 || isExcludedFromLimit[recipient], "Test:: Exceed max hold amount");

        if (isExcludedFromFee[sender] || isExcludedFromFee[recipient]) {
            super._transfer(sender, recipient, amount);
        } else {
            uint256 sendAmount = amount;
            uint256 feeAmount;
            //Buy Token
            if(automatedMarketMakerPairs[sender] && buyFee > 0) {
                require(block.timestamp - _lastTime[msg.sender] < 1 minutes, "Test:: Block sandwitch");
                feeAmount = amount * buyFee / 10000;
                sendAmount = amount - feeAmount;
                _lastTime[msg.sender] = block.timestamp;
            }
            //Sell Token
            if(automatedMarketMakerPairs[recipient] && sellFee > 0) {
                require(block.timestamp - _lastTime[msg.sender] < 1 minutes, "Test:: Block sandwitch");
                feeAmount = amount * sellFee / 10000;
                sendAmount = amount - feeAmount;
                _lastTime[msg.sender] = block.timestamp;
            }
            if(feeAmount > 0) {
                super._transfer(sender, feeWallet, feeAmount);
            }
            super._transfer(sender, recipient, sendAmount);         
        }

      
    }


    function transferOperator(address newOperator) public onlyOperator {
        require(newOperator != address(0), "Test:: New operator is the zero address");
        emit OperatorTransferred(operator, newOperator);
        operator = newOperator;
    }
    
    function setAutomatedMarketMakerPair(address pair, bool value) public onlyOperator {
        require(pair != uniswapV2Pair, "Test:: The pair cannot be removed from automatedMarketMakerPairs");

        _setAutomatedMarketMakerPair(pair, value);
    }

    function _setAutomatedMarketMakerPair(address pair, bool value) private {
        automatedMarketMakerPairs[pair] = value;

        emit SetAutomatedMarketMakerPair(pair, value);
    }
    function setExcludeFromFee(address _account, bool _bool) public onlyOperator {
        isExcludedFromFee[_account] = _bool;
    }
    function setExcludeFromLimit(address _account, bool _bool) public onlyOperator {
        isExcludedFromLimit[_account] = _bool;
    }

    /** 
     * @dev Update the dev wallet Address.
     * Can only be called by the current operator.
     */
    function updateFeeWallet(address _feeWallet) public {
        require( _feeWallet != address(0), "Test:: Tax fee address is zero" );
        require( msg.sender == feeWallet, "Test:: Caller is not old owner" );
        emit UpdateFeeWallet(_feeWallet);
        feeWallet = _feeWallet;
    }

    function updateBuyFee(uint16 _buyFee) public onlyOperator {
        require( _buyFee <= 1000, "Test:: Buy Fee can't exceed 10%" );
        emit UpdateBuyFee(_buyFee);
        buyFee = _buyFee;
    }

    function updateSellFee(uint16 _sellFee) public onlyOperator {
        require( _sellFee <= 1000, "Test:: Sell Fee can't exceed 10%");
        emit UpdateSellFee(_sellFee);
        sellFee = _sellFee;
    }
}