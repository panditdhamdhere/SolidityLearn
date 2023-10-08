// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SupplyChainTraceability {
    struct Product {
        string name;
        string origin;
        string[] certifications;
        uint256 timestamp;
        address owner;
    }

    mapping(uint256 => Product) public products;
    uint256 public productCount;

    event ProductCreated(
        uint256 indexed id,
        string name,
        string origin,
        address owner
    );
    event ProductTransferred(
        uint256 indexed id,
        address indexed previousOwner,
        address indexed newOwner
    );

    function createProduct(
        string memory _name,
        string memory _origin,
        string[] memory _certifications
    ) public {
        productCount++;
        products[productCount] = Product(
            _name,
            _origin,
            _certifications,
            block.timestamp,
            msg.sender
        );
        emit ProductCreated(productCount, _name, _origin, msg.sender);
    }

    function transferProduct(uint256 _id, address _newOwner) public {
        require(_id <= productCount, "Invalid product ID");
        require(
            products[_id].owner == msg.sender,
            "Only the current owner can transfer the product"
        );

        products[_id].owner = _newOwner;
        emit ProductTransferred(_id, msg.sender, _newOwner);
    }
}
