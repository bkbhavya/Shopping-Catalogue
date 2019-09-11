/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package shoppingcatalog.dto;

/**
 *
 * @author devanshi
 */
public class ItemOperationDTO {
    private String operationType;
    private String itemOperation;

    public String getOperationType() {
        return operationType;
    }

    public void setOperationType(String operationType) {
        this.operationType = operationType;
    }

    public String getItemOperation() {
        return itemOperation;
    }

    public void setItemOperation(String itemOperation) {
        this.itemOperation = itemOperation;
    }

}