// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract MyContract {
    address private admin1;
    address private admin2;

    constructor() {
        admin1 = 0x4c8b12BCAF4EA660279d81E038C196c5bf8C0d3f; //if u work on remix then change this off
        admin2 = 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB;
    }

    modifier onlyAdmin() {
        require(
            msg.sender == admin1 || msg.sender == admin2,
            "Only admin can execute this"
        );
        _;
    }

    modifier onlyDoctor() {
        require(doctors[msg.sender].age != 0, "Doctor doesn't exist");
        _;
    }
    modifier onlyPatient() {
        require(patients[msg.sender].age != 0, "Patient doesn't exist");
        _;
    }

    modifier onlyPharmacist() {
        require(pharmacists[msg.sender].age != 0, "Pharmacist doesn't exist");
        _;
    }
    modifier onlyPathologist() {
        require(pathologists[msg.sender].age != 0, "Pathologist doesn't exist");
        _;
    }

    // Define a Doctor struct at the contract level
    struct Doctor {
        string name;
        uint256 age;
    }

    // Define a mapping with address as the key and Doctor as the value
    mapping(address => Doctor) private doctors;

    // Store the addresses of all registered doctors
    address[] public allDoctors;

    // Function to add a new doctor
    function addDoctor(
        address _address,
        string memory _name,
        uint256 _age
    ) public onlyAdmin {
        doctors[_address] = Doctor(_name, _age);
        allDoctors.push(_address); // Add the doctor's address to the list
    }

    // Function to get the details of a doctor by address and return the address
    function getDoctor(
        address _address
    ) public view returns (address, string memory, uint256) {
        Doctor storage doctor = doctors[_address];
        require(bytes(doctor.name).length > 0, "Doctor not found");
        return (_address, doctor.name, doctor.age);
    }

    // Function to show a decorated list of all registered doctors
    function showOurDoctors()
        public
        view
        returns (address[] memory, string[] memory, uint256[] memory)
    {
        uint256 doctorCount = allDoctors.length;

        address[] memory doctorAddresses = new address[](doctorCount);
        string[] memory doctorNames = new string[](doctorCount);
        uint256[] memory doctorAges = new uint256[](doctorCount);

        for (uint256 i = 0; i < doctorCount; i++) {
            address doctorAddress = allDoctors[i];
            Doctor storage doctor = doctors[doctorAddress];

            doctorAddresses[i] = doctorAddress;
            doctorNames[i] = doctor.name;
            doctorAges[i] = doctor.age;
        }

        return (doctorAddresses, doctorNames, doctorAges);
    }

    // Add a function to remove a doctor by address
    function removeDoctor(address _address) public onlyAdmin {
        // Check if the doctor exists
        require(doctors[_address].age != 0, "Doctor doesn't exist");
        // Delete the doctor from the mapping
        delete doctors[_address];
        // Find and remove the doctor's address from the allDoctors array
        for (uint256 i = 0; i < allDoctors.length; i++) {
            if (allDoctors[i] == _address) {
                // Shift elements to fill the gap and reduce the array length
                for (uint256 j = i; j < allDoctors.length - 1; j++) {
                    allDoctors[j] = allDoctors[j + 1];
                }
                allDoctors.pop();
                break; // Exit the loop after removing the doctor
            }
        }
    }

    // Define a Patient struct at the contract level
    struct Patient {
        string name;
        uint256 age;
        string diseaseName;
        Prescription prescription;
        bool medicationDelivered;
        bool testRequested;
    }

    // Prescip struct
    struct Prescription {
        string medicationName;
        uint256 dosage;
        string instructions;
    }

    // Define a mapping with address as the key and Patient as the value
    mapping(address => Patient) private patients;

    // Store the addresses of all registered patients
    address[] public allPatients;

    // Function to add a new patient
    function addPatient(
        address _address,
        string memory _name,
        uint256 _age
    ) public onlyAdmin {
        patients[_address] = Patient(
            _name,
            _age,
            "",
            Prescription("", 0, ""),
            false,
            false
        );
        allPatients.push(_address); // Add the patient's address to the list
    }

    // Function to get the details of a patient by address and return the address
    function getPatient(
        address _address
    )
        public
        view
        returns (
            address,
            string memory,
            uint256,
            string memory,
            Prescription memory,
            bool,
            bool
        )
    {
        Patient storage patient = patients[_address];
        require(bytes(patient.name).length > 0, "Patient not found");
        return (
            _address,
            patient.name,
            patient.age,
            patient.diseaseName,
            patient.prescription,
            patient.medicationDelivered,
            patient.testRequested
        );
    }

    // Function to show a decorated list of all registered patients
    function showOurPatients()
        public
        view
        returns (address[] memory, string[] memory, uint256[] memory)
    {
        uint256 patientCount = allPatients.length;

        address[] memory patientAddresses = new address[](patientCount);
        string[] memory patientNames = new string[](patientCount);
        uint256[] memory patientAges = new uint256[](patientCount);

        for (uint256 i = 0; i < patientCount; i++) {
            address patientAddress = allPatients[i];
            Patient storage patient = patients[patientAddress];

            patientAddresses[i] = patientAddress;
            patientNames[i] = patient.name;
            patientAges[i] = patient.age;
        }

        return (patientAddresses, patientNames, patientAges);
    }

    // Add a function to remove a patient by address
    function removePatient(address _address) public onlyAdmin {
        // Check if the patient exists
        require(patients[_address].age != 0, "Patient doesn't exist");
        // Delete the patient from the mapping
        delete patients[_address];
        // Find and remove the patient's address from the allPatients array
        for (uint256 i = 0; i < allPatients.length; i++) {
            if (allPatients[i] == _address) {
                // Shift elements to fill the gap and reduce the array length
                for (uint256 j = i; j < allPatients.length - 1; j++) {
                    allPatients[j] = allPatients[j + 1];
                }
                allPatients.pop();
                break; // Exit the loop after removing the patient
            }
        }
    }

    // Function for doctors to add detailed prescription
    function addPrescription(
        address _patientAddress,
        string memory _medicationName,
        uint256 _dosage,
        string memory _instructions
    ) public onlyDoctor {
        Patient storage patient = patients[_patientAddress];
        require(bytes(patient.name).length > 0, "Patient not found");

        // Create a new Prescription struct with detailed information
        patient.prescription = Prescription(
            _medicationName,
            _dosage,
            _instructions
        );
        patient.testRequested = false; // Set testRequested to false when adding prescription
    }

    // Define a Pharmacist struct at the contract level
    struct Pharmacist {
        string name;
        uint256 age;
    }

    // Define a mapping with address as the key and Pharmacist as the value
    mapping(address => Pharmacist) private pharmacists;

    // Store the addresses of all registered pharmacists
    address[] public allPharmacists;

    // Function to add a new pharmacist
    function addPharmacist(
        address _address,
        string memory _name,
        uint256 _age
    ) public onlyAdmin {
        pharmacists[_address] = Pharmacist(_name, _age);
        allPharmacists.push(_address); // Add the pharmacist's address to the list
    }

    // Function to get the details of a pharmacist by address and return the address
    function getPharmacist(
        address _address
    ) public view returns (address, string memory, uint256) {
        Pharmacist storage pharmacist = pharmacists[_address];
        require(bytes(pharmacist.name).length > 0, "Pharmacist not found");
        return (_address, pharmacist.name, pharmacist.age);
    }

    // Function for pharmacists to mark medication as delivered
    function markMedicationDelivered(
        address _patientAddress
    ) public onlyPharmacist {
        Patient storage patient = patients[_patientAddress];
        require(bytes(patient.name).length > 0, "Patient not found");
        patient.medicationDelivered = true;
    }

    // Function to show a decorated list of all registered pharmacists
    function showOurPharmacists()
        public
        view
        returns (address[] memory, string[] memory, uint256[] memory)
    {
        uint256 pharmacistCount = allPharmacists.length;

        address[] memory pharmacistAddresses = new address[](pharmacistCount);
        string[] memory pharmacistNames = new string[](pharmacistCount);
        uint256[] memory pharmacistAges = new uint256[](pharmacistCount);

        for (uint256 i = 0; i < pharmacistCount; i++) {
            address pharmacistAddress = allPharmacists[i];
            Pharmacist storage pharmacist = pharmacists[pharmacistAddress];

            pharmacistAddresses[i] = pharmacistAddress;
            pharmacistNames[i] = pharmacist.name;
            pharmacistAges[i] = pharmacist.age;
        }

        return (pharmacistAddresses, pharmacistNames, pharmacistAges);
    }

    // Add a function to remove a pharmacist by address
    function removePharmacist(address _address) public onlyAdmin {
        // Check if the pharmacist exists
        require(pharmacists[_address].age != 0, "Pharmacist doesn't exist");
        // Delete the pharmacist from the mapping
        delete pharmacists[_address];
        // Find and remove the pharmacist's address from the allPharmacists array
        for (uint256 i = 0; i < allPharmacists.length; i++) {
            if (allPharmacists[i] == _address) {
                // Shift elements to fill the gap and reduce the array length
                for (uint256 j = i; j < allPharmacists.length - 1; j++) {
                    allPharmacists[j] = allPharmacists[j + 1];
                }
                allPharmacists.pop();
                break; // Exit the loop after removing the pharmacist
            }
        }
    }

    // Define a Pathologist struct at the contract level
    struct Pathologist {
        string name;
        uint256 age;
    }

    // Define a mapping with address as the key and Pathologist as the value
    mapping(address => Pathologist) private pathologists;

    // Store the addresses of all registered pathologists
    address[] public allPathologists;

    // Function to add a new pathologist
    function addPathologist(
        address _address,
        string memory _name,
        uint256 _age
    ) public onlyAdmin {
        pathologists[_address] = Pathologist(_name, _age);
        allPathologists.push(_address); // Add the pathologist's address to the list
    }

    // Function to get the details of a pathologist by address and return the address
    function getPathologist(
        address _address
    ) public view returns (address, string memory, uint256) {
        Pathologist storage pathologist = pathologists[_address];
        require(bytes(pathologist.name).length > 0, "Pathologist not found");
        return (_address, pathologist.name, pathologist.age);
    }

    // Function to show a decorated list of all registered pathologists
    function showOurPathologists()
        public
        view
        returns (address[] memory, string[] memory, uint256[] memory)
    {
        uint256 pathologistCount = allPathologists.length;

        address[] memory pathologistAddresses = new address[](pathologistCount);
        string[] memory pathologistNames = new string[](pathologistCount);
        uint256[] memory pathologistAges = new uint256[](pathologistCount);

        for (uint256 i = 0; i < pathologistCount; i++) {
            address pathologistAddress = allPathologists[i];
            Pathologist storage pathologist = pathologists[pathologistAddress];

            pathologistAddresses[i] = pathologistAddress;
            pathologistNames[i] = pathologist.name;
            pathologistAges[i] = pathologist.age;
        }

        return (pathologistAddresses, pathologistNames, pathologistAges);
    }

    // Add a function to remove a pathologist by address
    function removePathologist(address _address) public onlyAdmin {
        // Check if the pathologist exists
        require(pathologists[_address].age != 0, "Pathologist doesn't exist");
        // Delete the pathologist from the mapping
        delete pathologists[_address];
        // Find and remove the pathologist's address from the allPathologists array
        for (uint256 i = 0; i < allPathologists.length; i++) {
            if (allPathologists[i] == _address) {
                // Shift elements to fill the gap and reduce the array length
                for (uint256 j = i; j < allPathologists.length - 1; j++) {
                    allPathologists[j] = allPathologists[j + 1];
                }
                allPathologists.pop();
                break; // Exit the loop after removing the pathologist
            }
        }
    }

    // Function for doctors to request tests for patients
    function requestTest(address _patientAddress) public onlyDoctor {
        Patient storage patient = patients[_patientAddress];
        require(bytes(patient.name).length > 0, "Patient not found");
        patient.testRequested = true;
    }

    // Function for pathologists to access patient details when a test is requested
    function accessPatientDetails(
        address _patientAddress
    )
        public
        view
        onlyPathologist
        returns (
            address,
            string memory,
            uint256,
            string memory,
            Prescription memory,
            bool,
            bool
        )
    {
        Patient storage patient = patients[_patientAddress];
        require(patient.testRequested, "Test not requested for this patient");
        return (
            _patientAddress,
            patient.name,
            patient.age,
            patient.diseaseName,
            patient.prescription,
            patient.medicationDelivered,
            patient.testRequested
        );
    }
}
