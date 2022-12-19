pragma solidity ^0.8.17; 
import "hardhat/console.sol";

contract Scores {

    struct userScore{
        uint STT;
        uint MA_NHP;
        string MA_SV;
        string HOTEN_SV;
        string MA_MH;
        string MON_HOC;
        uint TIN_CHI;
        string DIEM_SO;
        string DIEM_CHU;
        string LY_DO;
    }
    mapping (uint => userScore) AllUserScores;
    
    uint public Count;
    address Admin = 0xD61298CBc34df66b07d42B3FC3B602DA7982c297;

    constructor() {
        Count = 0;
    }

// Giáo viên thêm điểm cho sinh viên
    function setScoreGV(uint _MA_NHP, string memory _MA_SV, string memory _HOTEN_SV,
                        string memory _MA_MH, string memory _MON_HOC, uint _TIN_CHI,
                        string memory _DIEM_SO, string memory _DIEM_CHU, string memory _LY_DO) public onlyAdmin {
        AllUserScores[Count] = userScore(Count,_MA_NHP, _MA_SV, _HOTEN_SV, _MA_MH, _MON_HOC, _TIN_CHI, _DIEM_SO, _DIEM_CHU, _LY_DO);
        Count++;
    }
    
// Giáo viên sửa điểm cho sinh viên
    function editScoreGV(string memory _MA_SV, uint _MA_NHP, 
                        string memory _DIEM_SO, string memory _DIEM_CHU, string memory _LY_DO) public onlyAdmin{
        for (uint i = 0; i < Count; i++) {
            if(keccak256(abi.encodePacked(AllUserScores[i].MA_SV)) == keccak256(abi.encodePacked(_MA_SV)) &&
                AllUserScores[i].MA_NHP == _MA_NHP
            ){
                AllUserScores[i].DIEM_SO = _DIEM_SO;
                AllUserScores[i].DIEM_CHU = _DIEM_CHU;
                AllUserScores[i].LY_DO = _LY_DO;
            }
        }
    }

// // Lấy điểm của tất cả sinh viên
//     function getScoreAllSV() public view returns (userScore[] memory){
//         userScore[]  memory scoreSV = new userScore[](Count);

//         for (uint i = 0; i < Count; i++) {
//             userScore storage info = AllUserScores[i];
//             scoreSV[i] = info;
//         }
//         return (scoreSV);
//     }

// Lấy tất cả điểm của sinh viên
    function getAllScoreSV(string memory _MA_SV) public view returns (userScore[] memory){
        userScore[]  memory scoreSV = new userScore[](Count);

        for (uint i = 0; i < Count; i++) {
            if(keccak256(abi.encodePacked(AllUserScores[i].MA_SV)) == keccak256(abi.encodePacked(_MA_SV))){
                userScore storage info = AllUserScores[i];
                scoreSV[i] = info;
            }
        }
        return (scoreSV);
    }

// Giáo viên lấy điểm của của sinh viên theo nhóm học phần
    function getScoreGV(uint _MA_NHP) public view returns (userScore[] memory){
        userScore[]  memory scoreSV = new userScore[](Count);

        for (uint i = 0; i < Count; i++) {
            if (AllUserScores[i].MA_NHP == _MA_NHP) {
                userScore storage info = AllUserScores[i];
                scoreSV[i] = info;
            }
        }
        return (scoreSV);
    }

    // Bảo mật cơ bản: Chỉ có người dùng có address Admin mới sử dụng được chức năng có onlyAdmin
    modifier onlyAdmin(){
        require (msg.sender == Admin, "only admin call function" );
        _;
    }
}

