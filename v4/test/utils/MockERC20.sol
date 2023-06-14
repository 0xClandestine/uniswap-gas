// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

library SafeMathLib {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }
}

contract MockERC20 {
    using SafeMathLib for uint256;

    string public name = "MOCK TOKEN";
    string public symbol = "MOCK";
    uint8 public constant decimals = 18;

    uint256 public totalSupply;

    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowances;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner, address indexed spender, uint256 value
    );

    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }

    function mint(address to, uint256 amount) public {
        totalSupply = totalSupply + amount;
        balances[to] = balances[to] + amount;
        emit Transfer(address(0), to, amount);
    }

    function transfer(address to, uint256 value) public returns (bool) {
        require(to != address(0), "ERC20: transfer to the zero address");
        require(value <= balances[msg.sender], "ERC20: insufficient balance");

        balances[msg.sender] = balances[msg.sender].sub(value);
        balances[to] = balances[to].add(value);
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) public returns (bool) {
        require(spender != address(0), "ERC20: approve to the zero address");
        allowances[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value)
        public
        returns (bool)
    {
        require(to != address(0), "ERC20: transfer to the zero address");
        require(value <= balances[from], "ERC20: insufficient balance");
        require(
            value <= allowances[from][msg.sender],
            "ERC20: insufficient allowance"
        );

        balances[from] = balances[from].sub(value);
        balances[to] = balances[to].add(value);
        allowances[from][msg.sender] = allowances[from][msg.sender].sub(value);
        emit Transfer(from, to, value);
        return true;
    }

    function allowance(address owner, address spender)
        public
        view
        returns (uint256)
    {
        return allowances[owner][spender];
    }
}
