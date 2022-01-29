package com.calculator;

import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    private TextView operationTextView, resultTextView;
    private String operator;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        resultTextView = findViewById(R.id.textViewResult);
        operationTextView = findViewById(R.id.textViewOperation);
    }

    public void onRemove(View view) {
        switch (view.getId()){
            case R.id.delete :
                String operation = operationTextView.getText().toString();
                String result = resultTextView.getText().toString();
                if (operator != null && operation.endsWith(operator)) operator = null;
                if(!operation.isEmpty() && result.isEmpty())
                    operationTextView.setText(operation.substring(0, operation.length() - 1));
                break;
            case R.id.clear :
                operationTextView.setText("");
                resultTextView.setText("");
                operator = null;
                break;
        }
    }

    public void onNumber(View view) {
        String operation = operationTextView.getText().toString();
        String result = resultTextView.getText().toString();
        if (result.isEmpty()){
            switch (view.getId()){
                case R.id.dot:
                    if (operator == null){
                        if (!operation.contains(".")) operationTextView.append(".");
                    } else {
                        int operatorIndex = operation.indexOf(operator);
                        String secondNumber = operation.substring(operatorIndex + 1);
                        if (!secondNumber.contains(".")) operationTextView.append(".");
                    }
                    break;
                case R.id.zero : operationTextView.append("0"); break;
                case R.id.one : operationTextView.append("1"); break;
                case R.id.two : operationTextView.append("2"); break;
                case R.id.three : operationTextView.append("3"); break;
                case R.id.four : operationTextView.append("4"); break;
                case R.id.five : operationTextView.append("5"); break;
                case R.id.six : operationTextView.append("6"); break;
                case R.id.seven : operationTextView.append("7"); break;
                case R.id.eight : operationTextView.append("8"); break;
                case R.id.nine : operationTextView.append("9"); break;
            }
        }
    }

    public void onOperate(View view) {
        if (operator == null && !operationTextView.getText().toString().isEmpty()){
            switch (view.getId()){
                case R.id.sum : operator = "+"; break;
                case R.id.sub : operator = "-"; break;
                case R.id.mul : operator = "*"; break;
                case R.id.div : operator = "/"; break;
            }
            operationTextView.append(operator);
        }
    }

    public void onEquals(View view) {
        String operation = operationTextView.getText().toString();
        if (operator != null && !operation.endsWith(operator)){
            int operatorIndex = operation.indexOf(operator);
            double firstNumber = Double.parseDouble(operation.substring(0, operatorIndex));
            double secondNumber = Double.parseDouble(operation.substring(operatorIndex + 1));
            double result = 0;
            switch (operator) {
                case "+": result = firstNumber + secondNumber; break;
                case "-": result = firstNumber - secondNumber; break;
                case "*": result = firstNumber * secondNumber; break;
                case "/": result = firstNumber / secondNumber; break;
            }
            resultTextView.setText(String.valueOf(result));
        }
    }

}