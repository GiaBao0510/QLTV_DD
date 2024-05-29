let data ={
    "danhsach":{
        "sinhvien":"NguyenVanA",
        "tuoi":21,
        "mssv":"b2016947",
    },
    "STT": 1
};

Object.assign(data['danhsach'] , {"diachi":"cantho"});

console.log(data);