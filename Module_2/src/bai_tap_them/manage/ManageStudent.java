package bai_tap_them.manage;

import bai_tap_them.controller.FileStudent;
import bai_tap_them.models.Student;

import java.util.ArrayList;
import java.util.Scanner;

public class ManageStudent {
    private final FileStudent fileStudent = new FileStudent();
    private final ArrayList<Student> list = new ArrayList<>();

    public String addNewStudent(Scanner input){
        this.updateListStudent();
        String id = this.checkInput(input, "id");
        String name = this.checkInput(input, "name");
        String gender = this.checkInput(input, "gender");
        String dayOfBirth = this.checkInput(input, "dayOfBirth");
        String nameClass = this.checkInput(input, "class");
        return fileStudent.writeFile(id+","+name+","+gender+","+dayOfBirth+","+nameClass, true);
    }

    private String checkInput(Scanner input, String type){
        String checkId = "[\\d]{5}";
        String checkName = "^[A-Z][a-z]*([\\s][A-Z][a-z]*)*$";
        String checkGender = "^(Male|Female|Unknow)$";
        String checkDayOfBirth = "^[0-3]\\d[/][0-1][0-9][/][0-9]{4}$";
        String checkClass = "[CAP][0-9]{4}[GHIKLM]";
        String regex;
        while (true) {
            switch (type) {
                case "id":
                    System.out.print("Id: ");
                    regex = checkId;
                    break;
                case "name":
                    System.out.print("Name: ");
                    regex = checkName;
                    break;
                case "gender":
                    System.out.print("Gender: ");
                    regex = checkGender;
                    break;
                case "dayOfBirth":
                    System.out.print("Day of birth: ");
                    regex = checkDayOfBirth;
                    break;
                case "class":
                    System.out.print("Class: ");
                    regex = checkClass;
                    break;
                default:
                    return "error";
            }
            String data = input.nextLine();
            if (data.matches(regex)) {
                if (type.equals("id")){
                    if (this.findId(data) != -1){
                        System.out.println("Id học sinh đã tồn tại.");
                        continue;
                    }
                }
                return data;
            } else {
                switch (type){
                    case "id":
                        System.out.println("Mã sinh viên phải là số nguyên có độ dài 5 kí tự");
                        break;
                    case "name":
                        System.out.println("Tên học sinh phải in hoa ký tự đầu tiên trong mỗi từ");
                        break;
                    case "gender":
                        System.out.println("Giới tính phải là Male, Female, Unknow");
                        break;
                    case "dayOfBirth":
                        System.out.println("Năm sinh phải đúng định dạng dd/mm/yyyy");
                        break;
                    case "class":
                        System.out.println("Tên class phải bắt đầu bằng chữ hoa A hoặc C hoặc P, theo sau là 4 kí tự và kết thúc " +
                                "bằng những kí tự hoa sau: G, H, I, K, L, M");
                        break;
                    default:
                        System.out.println("Kiểm tra lại code!!!");

                }
            }
        }
    }

    public String showAllStudent(){
        this.updateListStudent();
        ArrayList<Student> cloneList = (ArrayList<Student>)this.list.clone();
        cloneList.sort(new SortStudent(1));
        if (cloneList.isEmpty()){
            return "Student: no data";
        }
        StringBuilder output = new StringBuilder("Student: " + cloneList.size() + " available\n");
        for (int i=0; i<cloneList.size(); i++){
            output.append(i+1).append(". ").append(cloneList.get(i)).append("\n");
        }
        return output.substring(0, output.length()-1);
    }

    public String editStudent(Scanner input){
        System.out.print("Nhập id: ");
        String id = input.nextLine();
        this.updateListStudent();
        int localId = this.findId(id);
        if (localId==-1){
            return "Không tìm thấy Id học sinh.";
        }
        this.list.get(localId).setName(this.checkInput(input, "name"));
        this.list.get(localId).setGender(this.checkInput(input, "gender"));
        this.list.get(localId).setDateOfBirth(this.checkInput(input, "dayOfBirth"));
        this.list.get(localId).setNameClass(this.checkInput(input, "class"));
        System.out.println(convertListToString());
        return fileStudent.writeFile(convertListToString(), false);
    }

    public String deleteStudent(Scanner input){
        System.out.print("Nhập id: ");
        String id = input.nextLine();
        this.updateListStudent();
        int localId = this.findId(id);
        if (localId == -1){
            return "Không tìm thấy Id học sinh.";
        }
        this.list.remove(localId);
        System.out.println(convertListToString());
        return fileStudent.writeFile(this.convertListToString(), false);
    }

    public String searchStudent(Scanner input, String typeSearch){
        this.updateListStudent();
        if (this.list.isEmpty()){
            return "File rỗng. Kiểm tra lại file.";
        }
        switch (typeSearch){
            case "1":
                System.out.print("Nhập Id: ");
                String id = input.nextLine();
                return this.search(id, typeSearch);
            case "2":
                System.out.print("Nhập tên: ");
                String name = input.nextLine();
                return this.search(name, typeSearch);
            case "3":
                System.out.print("Nhập giới tính: ");
                String gender = input.nextLine();
                return this.search(gender, typeSearch);
            case "4":
                System.out.print("Nhập ngày tháng năm sinh: ");
                String dayOfBirth = input.nextLine();
                return this.search(dayOfBirth, typeSearch);
            case "5":
                System.out.print("Nhập tên lớp: ");
                String nameClass = input.nextLine();
                return this.search(nameClass, typeSearch);
            default:
                return "Kiểm tra lại code!!!";
        }
    }

    private String search(String value, String typeSearch){
        StringBuilder output = new StringBuilder();
        for (Student student : this.list){
            switch (typeSearch){
                case "1":
                    if (student.getId().equalsIgnoreCase(value)){
                        output.append(student.toString()).append("\n");
                    }
                    break;
                case "2":
                    if (student.getName().equalsIgnoreCase(value)){
                        output.append(student.toString()).append("\n");
                    }
                    break;
                case "3":
                    if (student.getGender().equalsIgnoreCase(value)){
                        output.append(student.toString()).append("\n");
                    }
                    break;
                case "4":
                    if (student.getDateOfBirth().equalsIgnoreCase(value)){
                        output.append(student.toString()).append("\n");
                    }
                    break;
                case "5":
                    if (student.getNameClass().equalsIgnoreCase(value)){
                        output.append(student.toString()).append("\n");
                    }
                    break;
            }

        }
        if (output.length()<1){
            return "Không tìm thấy";
        }
        return output.substring(0, output.length()-1);
    }

    public String sortStudent(String typeSort){
        this.updateListStudent();
        if (this.list.isEmpty()){
            return "File rỗng. Kiểm tra lại file.";
        }
        ArrayList<Student> cloneList = (ArrayList<Student>) this.list.clone();
        cloneList.sort(new SortStudent(Integer.parseInt(typeSort)));
        StringBuilder output = new StringBuilder();
        for (int i=0; i<cloneList.size(); i++){
            output.append(i+1).append(". ").append(cloneList.get(i).toString());
            if (i<cloneList.size()-1){
                output.append("\n");
            }
        }
        return output.toString();
    }

    private String convertListToString(){
        StringBuilder output = new StringBuilder();
        for (int i=0; i<this.list.size(); i++){
            output.append(this.list.get(i).getDataWriteFile());
            if (i<this.list.size()-1){
                output.append("\n");
            }
        }
        return output.toString();
    }

    private int findId(String id){
        if (this.list.isEmpty()){
            return -1;
        }
        for (int i=0; i<this.list.size(); i++){
            if (this.list.get(i).getId().equals(id)){
                return i;
            }
        }
        return -1;
    }

    private void updateListStudent(){
        String dataStudent = fileStudent.readFile();
        StringBuilder str = new StringBuilder();
        String[] saveData = new String[5];
        int count=0;
        this.list.clear();
        for (int i=0; i<dataStudent.length(); i++){
            if (dataStudent.charAt(i) == ','){
                saveData[count] = str.toString();
                count++;
                str = new StringBuilder();
                continue;
            }else if ((int)dataStudent.charAt(i) == 10){
                saveData[count] = str.toString();
                count=0;
                str = new StringBuilder();
                this.list.add(new Student(saveData[0], saveData[1], saveData[2], saveData[3], saveData[4]));
                continue;

            }else if ((int)dataStudent.charAt(i) == 13){
                continue;
            }
            str.append(dataStudent.charAt(i));
        }
    }
}
