package com.multi.matchingBoard;

import lombok.Data;

@Data
public class Message {

	private String roomId;
    private String from;
    private String fromId;
    private String text;

    // getters and setters
}
