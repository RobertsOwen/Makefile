# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: oroberts <oroberts@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/04/10 14:33:51 by oroberts          #+#    #+#              #
#    Updated: 2020/11/30 17:02:38 by oroberts         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME			=	TO_CHANGE

SRCS_DIR		=	./srcs/
SRCS			=	
vpath				%.cpp $(SRCS_DIR)

HEADERS_DIR		=	./headers/
HEADERS			=	
vpath				%.h $(HEADERS_DIR)

OBJS_DIR		=	./objs/
OBJS			=	$(addprefix $(OBJS_DIR), $(SRCS:.cpp=.o))
vpath				%.o $(OBJS_DIR)

DEP_DIR			=	./dependencies/
DEP				=	$(addprefix $(DEP_DIR), $(SRCS:.cpp=.d))
vpath				%.d $(DEP_DIR)

CC				=	clang++
CFLAGS			=	-Wall -Wextra -Werror -std=c++98
DEPFLAGS		=	-MT $@ -MMD -MP -MF $(DEP_DIR)$*.d
SHELL			=	/bin/bash

all				:	$(NAME)

$(NAME)			:	$(OBJS_DIR) $(OBJS)
					$(CC) $(CFLAGS) $(DEPFLAGS) $(OBJS) -o $(NAME)

$(OBJS_DIR)%.o	:	%.cpp $(DEP_DIR)%.d | $(DEP_DIR)
					$(CC) ${CFLAGS} $(DEPFLAGS) -o $@ -c $<

$(DEP_DIR)		:
					mkdir -p $(DEP_DIR)

$(OBJS_DIR)		:
					mkdir -p $(OBJS_DIR)

clean			:
					rm -rf $(OBJS_DIR)

fclean			:	clean
					rm -rf $(NAME)

dclean			:
					rm -rf $(DEP_DIR)

re				:	fclean	all

remake			:	fclean dclean
					sed -i "s/^SRCS\t.*/SRCS\t\t\t=\t$$(echo $$(ls $(SRCS_DIR) | grep .cpp))/" Makefile
					sed -i "s/^HEADERS\t.*/HEADERS\t\t\t=\t$$(echo $$(ls $(HEADERS_DIR) | grep .hpp))/" Makefile

.PHONY			:	all clean fclean re remake

$(DEP)			:
include $(wildcard $(DEP))