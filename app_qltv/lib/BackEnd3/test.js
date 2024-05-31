let data ={
    "danhsach":{
        "sinhvien":"NguyenVanA",
        "tuoi":21,
        "mssv":"b2016947",
    },
    "STT": 1
};

Object.assign(data['danhsach'] , {"diachi":"cantho"});

let day = new Date().toISOString().split('T')[0]

console.log(day);