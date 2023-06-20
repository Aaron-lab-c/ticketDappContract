// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract tickets is ERC1155, Ownable {
    /*座位分區*/
    uint constant private Zone_A = 0;
    uint constant private Zone_B = 1;
    uint constant private Zone_C = 2;
    uint constant private Zone_D = 3;
    uint constant private Staff = 4;

    uint constant private Zone_A_total = 100;
    uint constant private Zone_B_total = 200;
    uint constant private Zone_C_total = 300;
    uint constant private Zone_D_total = 400;

    uint  private Zone_A_counter = 0;
    uint  private Zone_B_counter = 0;
    uint  private Zone_C_counter = 0;
    uint  private Zone_D_counter = 0;

    string constant private BASE_URI = "https://ipfs.io/ipfs/QmfLB5hAE1MZdsHmueNRxFjZ4dEQUu7XYeKaXJr82btSZM/";
    string constant private JSON = ".json";
    bool public isPublicSale;
    constructor() ERC1155( "https://ipfs.io/ipfs/QmfLB5hAE1MZdsHmueNRxFjZ4dEQUu7XYeKaXJr82btSZM/{id}.json" )
    {
        _mint(msg.sender, Staff, 1, "host");
        //isPublicSale = false;
    }
    function destroyContract() public {
        require(msg.sender == owner(), "Only the contract owner can destroy the contract");
        selfdestruct(payable(owner())); //棄用
    }
    function uri (uint256 _tokenId) override public pure returns (string memory) {
        require( (_tokenId <=4 && _tokenId >= 0), "There is no this id." );
        return 
        string(
            abi.encodePacked(
            BASE_URI,
            Strings.toString(_tokenId),
            JSON)
        );
    }
    function setPublic() public onlyOwner {
        isPublicSale = true;
    }

    function setPause() public onlyOwner {
        isPublicSale = false;
    }
    function mint(address account, uint256 id, uint256 amount, bytes memory data)
        public
        onlyOwner
    {
        _mint(account, id, amount, data);
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
        onlyOwner
    {
        _mintBatch(to, ids, amounts, data);
    }

    function mintToZoneA(address account, uint256 id, uint256 amount, bytes memory data)
        public
    {   
        for (let i = 0; i < str.length; i++) {
            const charCode = str.charCodeAt(i);
            bytes.push(charCode);
        }
        require(id == 0, "only for Zone_A!");
        require(amount > 0, "Amount should be bigger than 0");
        require(amount <= 3, "You can only buy 3 tickets once.");
        require(Zone_A_counter+amount <= Zone_A_total,"Insufficient Zone_A tickets");
        require(balanceOf(account,id)+amount<=3,"The maximum number of tickets allowed per person is three.");

        _mint(account, id, amount, data);
        Zone_A_counter=Zone_A_counter+amount;
    }

    function mintToZoneB(address account, uint256 id, uint256 amount, bytes memory data)
        public
    {
        require(id == 1, "only for Zone_B!");
        require(amount > 0, "Amount should be bigger than 0");
        require(amount <= 3, "You can only buy 3 tickets once.");
        require(Zone_B_counter+amount <= Zone_B_total,"Insufficient Zone_B tickets");
        require(balanceOf(account,id)+amount<=3,"The maximum number of tickets allowed per person is three.");

        _mint(account, id, amount, data);
        Zone_B_counter=Zone_B_counter+amount;

    }
        function mintToZoneC(address account, uint256 id, uint256 amount, bytes memory data)
        public
    {
        require(id == 2, "only for Zone_C!");
        require(amount > 0, "Amount should be bigger than 0");
        require(amount <= 3, "You can only buy 3 tickets once.");
        require(Zone_C_counter+amount <= Zone_C_total,"Insufficient Zone_C tickets");
        require(balanceOf(account,id)+amount<=3,"The maximum number of tickets allowed per person is three.");

        _mint(account, id, amount, data);
        Zone_C_counter=Zone_C_counter+amount;
    }
        function mintToZoneD(address account, uint256 id, uint256 amount, bytes memory data)
        public
    {
        require(id == 3, "only for Zone_D!");
        require(amount > 0, "Amount should be bigger than 0");
        require(amount <= 3, "You can only buy 3 tickets once.");
        require(Zone_D_counter+amount <= Zone_D_total,"Insufficient Zone_D tickets");
        require(balanceOf(account,id)+amount<=3,"The maximum number of tickets allowed per person is three.");

        _mint(account, id, amount, data);
        Zone_D_counter=Zone_D_counter+amount;

    }
}