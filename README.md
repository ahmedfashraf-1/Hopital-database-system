# 🏥 Hospital Database System

## 📌 Entities
The project covers the main hospital entities:

- **Patient Management**  
  - Patient  
  - Contact  
  - Allergy  

- **Appointments & Scheduling**  
  - Appointment  
  - Provider  
  - Department  
  - Room  

- **Encounters**  
  - Encounter  
  - Admission  
  - Bed Assignment  

- **Orders & Results**  
  - Order  
  - Order Item  
  - Result  
  - Service  

- **Pharmacy**  
  - Prescription  
  - Prescription Line  
  - Dispense Record  
  - Drug  

- **Clinical Documentation**  
  - Note  
  - Vital  
  - Diagnosis  

- **Billing & Insurance**  
  - Invoice  
  - Charge  
  - Payment  
  - Claim  
  - Payer  

- **Inventory & Procurement**  
  - Inventory Item  
  - Stock Lot  
  - Supplier  
  - Purchase Order  

- **Operating Theatre**  
  - OR Schedule  
  - Consumables  

- **Document Management**  
  - Document  

- **Administration & Security**  
  - User  
  - Role  
  - Audit Event  

---

## 📊 Relationships
- **One-to-Many**:  
  - Patient → Contacts  
  - Patient → Allergies  
  - Order → Order Items  

- **Many-to-One**:  
  - Appointment → Patient / Provider / Department  
  - Encounter → Patient  

- **One-to-One**:  
  - Encounter → Admission  
  - Order Item → Result  

- **Many-to-Many**:  
  - User ↔ Role (via User-Role table)  

- **Polymorphic**:  
  - Document linked to different owner types (Patient, Provider, etc.)  

---

## ⚙️ Run the Project
1. Open the terminal and navigate to the project folder:  
   ```bash
   cd SQL_Hospital_Project
   python app.py
